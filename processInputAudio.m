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
function outputVector = processInputAudio(inputAudio, fs)

% If input audio is a filename, then read it.
if ischar(inputAudio)
%     fileName = inputAudio;
    inputAudio = audioread(inputAudio);
end

% Mix into one stereo track
if size(inputAudio,2) == 2
    inputAudio = downMix(inputAudio);
end

% Remove last eight seconds (presumably silence because of recording
% auto-stop)
if length(inputAudio)<(fs*4)
    'Audio file is too short for analysis'
    return
else
    inputAudio = inputAudio(1:(end-fs*8));
end

outputVector = inputAudio;