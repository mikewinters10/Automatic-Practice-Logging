initWorkspace;
matches = findMatchingTracksForSectionsAndDate(3, '140502');

numFilterIterations = 3;
topPercentageOfCandidates = 0.2;

for i = 1:length(matches);
    q = createFeatureMatrixFromSection(matches{i}, bigHopSize, bigWinSize);
    q = findAllCandidates(q,r);
    q = filterCandidates(q, numFilterIterations, topPercentageOfCandidates);
    % Perform DTWs
    plotFilteredCandidates(q, r)
end

% Plot "Non-Zero Frames"
% Do DTWs
% Do costs coloration