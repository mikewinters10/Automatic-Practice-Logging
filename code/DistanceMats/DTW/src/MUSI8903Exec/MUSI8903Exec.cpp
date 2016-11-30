 
#include <iostream>
#include <ctime>
#include <string>
#include <fstream>

#include "MUSI8903Config.h"
#include "Dtw.h"

using namespace std;

// local function declarations

/////////////////////////////////////////////////////////////////////////////////
// main function
int main(int argc, char* argv[])
{
	int row, col,path_length, start_idx;
	clock_t time = 0;
	int** path = 0;
	float **DistMat = 0;
	string infilepath, outfilepath;
	fstream infile, outfile;

	row = stoi(argv[1]);
	col = stoi(argv[2]);
	start_idx = stoi(argv[3]);
	infilepath = argv[4];
	outfilepath = argv[5];
	// Allocate memory for distance matrix and data_read buffer
	col = col - start_idx;
	DistMat = new float*[row];
	for (int i = 0; i < row; i++)
		DistMat[i] = new float[col];
	float *raw_buffer = new float[row*col];
	time = clock();
	// Open files
	infile.open(infilepath, ios::in|ios::binary);
	outfile.open(outfilepath, ios::out|ios::binary);
	//outfile.open(outfilepath, fstream::out);
	//cout << infile.is_open() << endl;
	
	
	// Read data from file
	//infile.seekg(start_idx*sizeof(float)*row);
	//infile.read(reinterpret_cast<char*>(&raw_buffer[0]), sizeof(float)*row*col);
	//for (int i = 0;i < col; i++)
	//{
	//	for (int j = 0; j < row; j++)
	//	{
	//		DistMat[j][i] = raw_buffer[i*row + j];
	//	}
	//}

	for (int i = 0; i < row; i++)
	{
		infile.seekg((start_idx+i*(col+start_idx))*sizeof(float));
		infile.read(reinterpret_cast<char*>(&DistMat[i][0]), sizeof(float)*col);
	}



	//for (int i = 0; i < col; i++)
	//{
	//	for (int j = 0;j < row;j++)
	//	{
	//		//infile >> DistMat[i][j];
	//		infile.read(reinterpret_cast<char*>(&DistMat[j][i]), sizeof DistMat[j][i]);
	//	}
	//}
	//cout << DistMat[0][0] << endl << DistMat[0][1] << endl;
	infile.close();
	//time = clock();
	//cout << "Staring DTW" << endl;
	CDtw *dtw = new CDtw();
	dtw->init(row, col);
	dtw->process(DistMat);
	int location;
	path_length = dtw->getPathLength();
	float cost = dtw->getPathCost(location);
	float loc = static_cast<float>(location);
	float length = static_cast<float>(path_length);
	outfile.write(reinterpret_cast<char*>(&length), sizeof length);
	outfile.write(reinterpret_cast<char*>(&cost), sizeof cost);
	outfile.write(reinterpret_cast<char*>(&loc), sizeof loc);
	//cout<< "DTW done in: \t" << (clock() - time)*1.F / CLOCKS_PER_SEC << " seconds." << endl<<"Length: "<<path_length<<endl;
	
	
	
	//Clear buffers and close file pointers
	outfile.close();
	for (int i = 0; i < row; i++)
		delete[] DistMat[i];
	delete[] DistMat;
    return 0;
    
}