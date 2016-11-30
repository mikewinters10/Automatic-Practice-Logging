% ======================================================================
% This code written by R. Michael Winters
% Date created: November 28, 2016
%
%> @brief : returns the matching reference section for a given snipet,
%>      a snipet is defined by a start and an end frame
%> called by :: getSnipetResultsForSegment.m
%>
%> @param qStruct: The struct of the query track, including all features,
%> and non-zeroFrames
%> @param rStruct: The struct array of the reference tracks
%>
%> @retval qStruct: The original qStruct with all of the candidates
% ======================================================================

function matchingRefTrack = returnMatchingRefSectionForSnipet(qStruct, snipetStartIndx, snipetEndIndx)

% Convert start and end boundaries to indexes into the nZF vector
startIndx   = find(qStruct.nZF == snipetStartIndx);
endIndx     = find(qStruct.nZF == snipetEndIndx);

% Retrieve the candidate costs
candidateCosts = squeeze(qStruct.filteredCandidates(3,:,startIndx:endIndx));

% Retrieve possible matches
numRefTracks        = qStruct.numRefTracks;
numNZF              = size(candidateCosts,2);
numMatchesToReturn  = qStruct.numMatchesToReturn;

% Create an numRefTracksxnumNZF array for answers
numMatchesPerNZF = zeros(numRefTracks, numNZF);

for i = 1:numNZF
    for j = 1:numRefTracks
        % Get the correct indexes for each reference track
        candidateIdx = (j-1)*numMatchesToReturn + 1: j*numMatchesToReturn;
        
        % What are is the total number of Matches per NZF?
        numMatchesPerNZF(j,i) = length(find(candidateCosts(candidateIdx,i)));
    end
end

% Determine matching section number by suming the number of matches
[numMatchesForRefTrack, matchingRefTrack] = max(sum(numMatchesPerNZF,2));