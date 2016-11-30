% This code written by R. Michael Winters
% Date created: February 22, 2016
%
%> @brief Load in all of the default variables into Matlab
%>
%> @param 
%>
%> @retval
% ======================================================================

% Add code to path
addpath(genpath('code'))
rmpath(genpath('code/DistanceMats'))
addpath(genpath('referenceTracks'))
addpath(genpath('APL_Dataset'))

% Set global variables
winSizesToSearch = [8, 10, 12, 14, 16, 18];
bigWinSize = 16; % * winSize
bigHopSize = 4; % * winSize
fs = 44100;

% For query audio, we try to remove any bigWinSize windows with signifcant
% pauses
removeSilence = true;

% Create the feature matrix
r = saveRefFeatureMatrices(bigHopSize, bigWinSize, winSizesToSearch);