initWorkspace;
matches = findMatchingTracksForSectionsAndDate(3, '140502');

numFilterIterations = 4;
topPercentageOfCandidates = 0.20;

% Create a confusion matrix for the results
confusionMatrix = zeros(q.numRefTracks, q.numRefTracks);

for i = 80:length(matches);
    %disp(['Computing ' num2str(matches{i}.endSec - matches{1}.startSec) ' seconds of audio']);
    % Create feature matrix from section
    q = createFeatureMatrixFromSection(matches{i}, bigHopSize, bigWinSize);
    % Find all candidates just from feature matrix (i.e. Pitch-chroma and
    % windows
    q = findAllCandidates(q,r);
    % Filter these candidates to only include those with lowest costs
    q = filterCandidates(q, numFilterIterations, topPercentageOfCandidates);
    
    % Sum try to predict the correct reference track number
    matchingRefTrack = returnMatchingRefTrackForCandidates(q);
    
    % Display the results
    disp(['Annotation: ' q.inputAudioStruct.section '--- Result: ' num2str(matchingRefTrack)]);
    
    % Add the result to the confusion matrix
    confusionMatrix(num2str(q.inputAudioStruct.section(9:end))) = ...
        confusionMatrix(num2str(q.inputAudioStruct.section(9:end))) + 1;
    
    % Perform DTWs
%    q = performDTWs(q, r);
%     % Do more filtering with the new costs
%    q = filterCandidates(q, 0, 0.5, true);
    % Plot the results
   % plotFilteredCandidates(q, r, 'filtered')
   % plotFilteredCandidates(q, r, 'DTWs')
end