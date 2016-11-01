% A function to count the number of matches for a given section
% Currently called by demoScript.m
%
% Written by R. Michael Winters, Nov. 1, 2016

function matchingRefTrack = returnMatchingRefTrackForCandidates(qStruct)

% Retrieve the candidate costs
candidateCosts = squeeze(qStruct.filteredCandidates(3,:,:));

% Retrieve possible matches
numRefTracks        = qStruct.numRefTracks;
numNZF              = length(qStruct.nZF);
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