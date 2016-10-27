initWorkspace;
matches = findMatchingTracksForSectionsAndDate(3, '140502');

numFilterIterations = 3;
topPercentageOfCandidates = 0.2;

for i = 1:length(matches);
    % Create feature matrix from section
    q = createFeatureMatrixFromSection(matches{i}, bigHopSize, bigWinSize);
    % Find all candidates just from feature matrix (i.e. Pitch-chroma and
    % windows
    q = findAllCandidates(q,r);
    % Filter these candidates to only include those with lowest costs
    q = filterCandidates(q, numFilterIterations, topPercentageOfCandidates);
    % Perform DTWs
    q = performDTWs(q, r);
    % Plot the results
    plotFilteredCandidates(q, r)
end

% Plot "Non-Zero Frames"
% Do DTWs
% Do costs coloration