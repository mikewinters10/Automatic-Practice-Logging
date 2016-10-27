initWorkspace;
matches = findMatchingTracksForSectionsAndDate(3, '140502');

numFilterIterations = 3;
topPercentageOfCandidates = 0.15;

for i = 1:length(matches);
    tic;
    disp(['Computing ' num2str(matches{i}.endSec - matches{1}.startSec) ' seconds']);
    % Create feature matrix from section
    q = createFeatureMatrixFromSection(matches{i}, bigHopSize, bigWinSize);
    % Find all candidates just from feature matrix (i.e. Pitch-chroma and
    % windows
    q = findAllCandidates(q,r);
    % Filter these candidates to only include those with lowest costs
    q = filterCandidates(q, numFilterIterations, topPercentageOfCandidates);
    % Perform DTWs
    q = performDTWs(q, r);
%     % Do more filtering with the new costs
%     q = filterCandidates(q, 0, 0.5, true);
    % Plot the results
    plotFilteredCandidates(q, r, 'filtered')
    plotFilteredCandidates(q, r, 'DTWs')
    toc;
end

% Plot "Non-Zero Frames"
% Do DTWs
% Do costs coloration