% ======================================================================
% This code written by R. Michael Winters
% Date created: February 18, 2016
%
%> @brief searches for best matching reference track for all frames in a
%> query file.
%> called by :: ??
%>
%> @param qStruct: The struct of the query track, including all features,
%> and non-zeroFrames
%> @param rStruct: The struct array of the reference tracks
%>
%> @retval qStruct: The original qStruct with all of the candidates
% ======================================================================
function qStruct = findAllCandidates(qStruct, rStruct)

% Do an error check. They should have the same bigWinSize and bigHopSize;
if qStruct.bigWinSize ~= rStruct.r1.bigWinSize
    error('BigWinSize is not the same between query and reference')
elseif qStruct.bigHopSize ~= rStruct.r1.bigHopSize
    error('BigWinSize is not the same between query and reference')
end
    
% Save the number of nonZeroFrames to search over
lenNZF = length(qStruct.nZF);

% The number of matches to return for each reference track
numMatchesToReturn = 15;
qStruct.numMatchesToReturn = numMatchesToReturn;

numRefTracks = size(rStruct.filenames,2);
qStruct.numRefTracks = numRefTracks;

% Create a new results array allowing comparison across multiple NZFs
candidates = zeros(3, numRefTracks*numMatchesToReturn, lenNZF);

% Best matches is filled with the 5 best results for each reference track
bestMatches = zeros( 3 , numMatchesToReturn * numRefTracks );

for i = 1:lenNZF
        
    % Find the best numResultsToReturn for each reference track.
    for j = 1:numRefTracks

        % Generate a list of numMatchesToReturn for each referenceTrack. 
        eval(['bestMatches( : , (j-1) * numMatchesToReturn + 1 : j * numMatchesToReturn)' ...
            ' = searchForSimilarFrame(qStruct, qStruct.nZF(i), rStruct.r' num2str(j) ...
             ', numMatchesToReturn);']);
    end
    
    % Doing this will allow us to compare across different all non-zero frames
    candidates(:,:,i) = bestMatches;
    
    % Post the current frame
    if mod(i,10)==0
        [num2str(i) ' of ' num2str(lenNZF)] 
    end
end

qStruct.allCandidates = candidates;




