function qStruct = filterCandidates(qStruct, numIterations, costThreshold)

candidates = qStruct.allCandidates;
numRefTracks = qStruct.numRefTracks;

filteredCandidates = zeros(size(candidates));

% Add filter parameteres to qStruct
qStruct.costThreshold = costThreshold;
qStruct.numFilterIterations = numIterations;

% In this step, threshold the costs to get rid of high costs
for i = 1:length(qStruct.nZF)
    % Find the indexes of elements that have costs below a threshold amount
    candidatesBelowThreshold = candidates(3,:,i) < qStruct.costThreshold;
    
    % Use these indexes to selectively choose results below the threshold
    filteredCandidates(:,candidatesBelowThreshold,i) = candidates(:,candidatesBelowThreshold,i);
end

% In this step, choose frames that have future neighbors that are nearby
for i = 1:numIterations
    filteredCandidates = findStepwiseIncreasingCandidates(filteredCandidates, numRefTracks);
end
% 

qStruct.filteredCandidates = filteredCandidates;
