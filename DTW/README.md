# DTW Library

Requirements:
CMake
Supported C++ compiler (Xcode, VC++, etc)

Instructions:
Run CMake
Browse to project directory
Set Build directory
Configure, until none of the entries are red
Generate

Usage:
Build the executable in release mode
Write the distance matrix from Matlab in binary, column-wise.
Run the executable from Matlab using the 'system' call function. 
  Arguments: num_rows, num_columns, start_point in distance matrix, distance matrix binary filepath, desired output filepath
C++ function writes path_length, cost and location, in order, into a binary output file.
Read the file in Matlab and continue computation
