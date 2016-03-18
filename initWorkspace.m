% This code written by R. Michael Winters
% Date created: February 22, 2016
%
%> @brief Load in all of the default variables into Matlab
%>
%> @param 
%>
%> @retval
% ======================================================================

inputAudio = '1-140507-023.mp3';
% 
winSizesToSearch = [8, 10, 12, 14, 16, 18];
% winSizesToSearch = [6, 8, 10, 12, 14, 16];
bigWinSize = 16; % * winSize
bigHopSize = 4; % * winSize
fs = 44100;

%q = createFeatureMatrix(inputAudio);

% Create a series of versions biased towards slower versions than the reference (32).
% winSizesToSearch = [16, 20, 24, 28, 32, 36];
% bigWinSize = 32;
% bigHopSize = 4;

% For query audio, we try to remove any bigWinSize windows with signifcant
% pauses
removeSilence = true;

% Create the feature matrix
q = createFeatureMatrix(inputAudio, bigHopSize, bigWinSize, removeSilence)

r = saveRefFeatureMatrices(bigHopSize, bigWinSize, winSizesToSearch)