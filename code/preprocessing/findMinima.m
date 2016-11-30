function [mins, locs] = findMinima(Array)

% The current maxium of the array:
max1DArray = max(Array);

% Flip the array over so that the mins are now the maxes
inv1DArray = max1DArray - Array;

% Discover the locations
[~, locs] = findpeaks(inv1DArray);

% Return peaks to their previous value:
mins = max1DArray - inv1DArray;

% Use only those min values
mins = mins(locs);