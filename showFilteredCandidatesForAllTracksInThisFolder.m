function showFilteredCandidatesForAllTracksInThisFolder(folderName, rStruct)

% Default to movement 3 for now:
movementNumber = 3;

% Get global variables from the 
bigHopSize = rStruct.bigHopSize;
bigWinSize = rStruct.bigWinSize;
removePauses = true;

matches = findMatchingTracksForMvtAndDate(movementNumber, folderName);

numFilterIterations = 1;
costThreshold = 0.2;

for i = 1:length(matches)
    
    % Create the feature matrix for this query track
    q = createFeatureMatrix(matches{i}, bigHopSize, bigWinSize, removePauses);
    
    % Find the possible candidates
    q = findAllCandidates(q, rStruct);
    
    % Filter out the bad candidates
    q = filterCandidates(q, numFilterIterations, costThreshold);
    
    % Plot the results
    plotFilteredCandidates(q, rStruct);
end
