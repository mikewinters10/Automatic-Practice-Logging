% ======================================================================
% This code written by R. Michael Winters
% Date created: February 16, 2016
%
%> @brief finds the most similar frames for a given query.
%> called by ::
%>
%> @param fs: The sampling rate of everything (assummed to be the same for
% query and reference
%>
%> @retval matches: Mvt1, Mvt2, Mvt3 structs containing structs of the
% different features
%>
% ======================================================================
function refStruct = saveRefFeatureMatrices(fs)

% Global winSizes and hopSizes
winSize = [0.5, 0.75, 1.0, 1.25];
hopSize = 0.25;

% Declare the reference tracks
refTracks = {'140517-049.mp3','140517-050.mp3','140517-051.mp3'};

% For quick reference in the struct
refStruct.filenames = refTracks;
refStruct.hopSize = hopSize;
refStruct.winSize = winSize;

numRefTracks = size(refTracks,2);

for i=1:numRefTracks
    trackName = refTracks{i};
    for j=1:length(winSize)
        eval(['refStruct.r' num2str(i) '.w' num2str(j) ' = createFeatureMatrix(trackName,' num2str(winSize(j)) ', hopSize, fs);']);
    end
end

save('refStructFeatMat', 'refStruct')
