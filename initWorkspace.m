% This code written by R. Michael Winters
% Date created: February 22, 2016
%
%> @brief Load in all of the default variables into Matlab
%>
%> @param 
%>
%> @retval
% ======================================================================

winSizeInSec = 1;
hopSizeInSec = 0.5;
fs = 44100;
inputAudio = '140602-000.mp3';

q = createFeatureMatrix(inputAudio, winSizeInSec, hopSizeInSec, fs);

load('refStructFeatMat.mat');