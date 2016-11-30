
function findCandidatesForMovementAndDates(movement, dates)

% Initialize (currently only third movement is annotated)
movement = 3;
dates = {'140502', '140504'};

% Go find the start and end points for each annotation
snipets = findMatchingSnipetsForSectionsAndDates(movement, dates);

% Sometimes you don't want to do all of the snipets to save time
startIdx = 1;

% Percentages and iterations to use
topCostPercents = 0.05:0.05:0.15;
numFiltIterations = 1:3;

% Create a place for results of grid search:
gridResults = zeros(length(topCostPercents), length(numFiltIterations));

% Results
evaluationResults = zeros(length(topCostPercents), length(numFiltIterations), ...
    length(r.filenames), length(r.filenames));

% For all snipets
for i = startIdx:length(snipets);
    
    tic;
    disp(['Computing match ' num2str(i) ' of ' num2str(length(snipets)) '. ' ...
        num2str(snipets{i}.endSec - snipets{i}.startSec) ' seconds of audio']);
    
    % Create feature matrix from section
    q = createFeatureMatrixFromSection(snipets{i}, bigHopSize, bigWinSize);

    % Find all candidates just from feature matrix
    q = findAllCandidates(q,r);
    
    if i == 1
        fullResults = q;
    else
        fullResults = [fullResults, q];
        disp(['Size of full results: ' num2str(length(fullResults))]);
    end
    
    % Now experiment with different parameters
%     for j = 1:length(topCostPercents)
%         topPercentageOfCandidates = topCostPercents(j);
%         
%         % For each number of filter iterations
%         for k=1:length(numFiltIterations); 
%             numFilterIterations = numFiltIterations(k);
%             
%             % Filter these candidates to include the most likely
%             q = filterCandidates(q, numFilterIterations, topPercentageOfCandidates);
% 
%             % Sum try to predict the correct reference track number
%             matchingRefTrack = returnMatchingRefSectionForCandidates(q);
% 
%             % Display the results
%             disp(['CostThreshold: ' num2str(topCostPercents(k)) '. Filter Iterations:' num2str(numFiltIterations(j))]);
%             %disp(['Annotation: ' q.inputAudioStruct.section '--- Result: ' num2str(matchingRefTrack)]);
%             %disp('');
%             
%             % Create a 4-D matrix with one confusion matrix per j and k
%             evaluationResults(j,k,str2double(q.inputAudioStruct.section(9:end)), matchingRefTrack) = ...
%                 evaluationResults(j,k,str2double(q.inputAudioStruct.section(9:end)), matchingRefTrack) + 1;
% 
%             % Perform DTWs
%             % q = performDTWs(q, r);
%             % Plot the results
%             % plotFilteredCandidates(q, r, 'filtered')
%         end
%     end
    
    toc;
    % Plot the results;

end

save('evaluationResults','evaluationResults')
save('fullResults','fullResults')

plotEvaluationResults(evaluationResults, topCostPercents, numFiltIterations)
% Compute accuracy and save
% accuracy = trace(confusionMatrix)/sum(sum(confusionMatrix));
% gridResults(j,k) = accuracy;
%     
    
% Plot grid results
figure;
imagesc(gridResults);