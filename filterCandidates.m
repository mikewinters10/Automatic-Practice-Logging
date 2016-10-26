% ======================================================================
% This code written by R. Michael Winters
% Date created: October 20, 2016
%
%> @brief removes unlikely candidates from the full candidate pool
%> called by :: (currently "demoScript.m"
%>
%> @param qStruct: The struct of the query track, including all features,
%> and non-zeroFrames
%> @param numIterations: number of times to apply the forward looking
%algorithm
%> @param costThreshold: what top percentage of candidates to keep?
%>
%> @retval qStruct: The original qStruct with all of the candidates
% ======================================================================

function qStruct = filterCandidates(qStruct, numIterations, costThreshold)

candidates = qStruct.allCandidates;
numRefTracks = qStruct.numRefTracks;

filteredCandidates = zeros(size(candidates));
numLowestCosts = ceil(size(candidates,2) * costThreshold);

% Add filter parameteres to qStruct
qStruct.costThreshold = costThreshold;
qStruct.numFilterIterations = numIterations;

% In this step, threshold the costs to get rid of high costs
for i = 1:length(qStruct.nZF)
    
    % Find the indexes of elements that have costs below a threshold amount
    [~, indices] = sort(candidates(3,:,i));
    minIndices = indices(1:numLowestCosts);
   
    % Use these indexes to selectively choose results below the threshold
    filteredCandidates(:,minIndices,i) = candidates(:,minIndices,i);
end

% In this step, choose frames that have future neighbors that are nearby
for i = 1:numIterations
    filteredCandidates = findStepwiseIncreasingCandidates(filteredCandidates, numRefTracks);
end
% 

qStruct.filteredCandidates = filteredCandidates;
