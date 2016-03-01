% ======================================================================
% This code written by R. Michael Winters
% Date created: March 1, 2016
%
%> @brief searches all files in the queryAudio directory against the
%> refStruct
%>
%> @retval results: A numNonZeroFrame block with best resulting track  
% ======================================================================

filenames = dir('queryAudio/*.mp3');

numFilenames = size(filenames,1);

for i = 1:numFilenames
    q = createFeatureMatrix(filenames(i).name,winSizeInSec,0.25,fs);
    searchAllNonZeroFrames(q,refStruct)
end