% ======================================================================
% This code written by R. Michael Winters
% Date created: February 2, 2016
%
%> @brief Remove stereo tracks, throw error if too short, do any other
% pre-processing needed.
%> called by :: createFeatureMatrix.m
%>
%> @param inputAudio: A vector or a string indicating the input audio
%> @param fs: Sampling rate
%>
%> @retval outputVector: A single channel Matlab vector.
% ======================================================================
% A function to remove long periods of silence from an input file.
function outputVector = processInputAudio(inputAudio, fs, startSec, endSec)

% If input audio is a filename, then read it.
if ischar(inputAudio)
%     fileName = inputAudio;
    inputAudio = audioread(inputAudio);
end

% Mix into one stereo track
if size(inputAudio,2) == 2
    inputAudio = downMix(inputAudio);
end

if nargin < 3
    startSample = 1;
    endSample = length(inputAudio);
else
    startSample = startSec * fs + 1;
    endSample = (endSec * fs) + fs + 1;
    if endSample > length(inputAudio)
        endSample = length(inputAudio);
    end
end

% Only use the desired portion
inputAudio = inputAudio(startSample:endSample);

% 
% if length(inputAudio)<(fs*4)
%     'Audio file is too short for analysis'
%     return
% end

outputVector = inputAudio;