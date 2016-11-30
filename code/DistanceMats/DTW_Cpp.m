function [cost, path_length] = DTW_Cpp(distMat)

% path = '~/Desktop/ACPA/DistanceMats/';
path = 'DistanceMats/';
distfile = [path, 'distmat.bin'];
outfile = [path, 'output.bin'];
executable = [path, 'MUSI8903Exec'];

fid = fopen(distfile,'w');
fwrite(fid, distMat', 'float');
fclose(fid);

% DTW output:   1: path length
%               2: cost
%               3: location at the end
system([executable ' ' num2str(size(distMat,1)) ' ' num2str(size(distMat,2)) ' ' num2str(0) ' ' distfile ' ' outfile]);
fid = fopen(outfile,'r');
dtw_out = fread(fid, [3 1], 'float');
fclose(fid);
cost = dtw_out(2);
path_length = dtw_out(1);