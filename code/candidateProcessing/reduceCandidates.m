% A script to play with reducing candidates

function reduceCandidates(qStruct)

% Percentages and iterations to use
topCostPercents = 0.05;
numFiltIterations = 1;

for i = 1:
        % Now experiment with different parameters
    for j = 1:length(topCostPercents)
        topPercentageOfCandidates = topCostPercents(j);
        
        % For each number of filter iterations
        for k=1:length(numFiltIterations); 
            numFilterIterations = numFiltIterations(k);
            
            % Filter these candidates to include the most likely
            q(i) = filterCandidates(q(i), numFilterIterations, topPercentageOfCandidates);

            % Sum try to predict the correct reference track number
            matchingRefTrack = returnMatchingRefTrackForCandidates(q(i));

            % Display the results
            disp(['CostThreshold: ' num2str(topCostPercents(k)) '. Filter Iterations:' num2str(numFiltIterations(j))]);
            %disp(['Annotation: ' q.inputAudioStruct.section '--- Result: ' num2str(matchingRefTrack)]);
            %disp('');
            
            % Create a 4-D matrix with one confusion matrix per j and k
            evaluationResults(j,k,str2double(q.inputAudioStruct.section(9:end)), matchingRefTrack) = ...
                evaluationResults(j,k,str2double(q.inputAudioStruct.section(9:end)), matchingRefTrack) + 1;

            % Perform DTWs
            % q = performDTWs(q, r);
            % Plot the results
            % plotFilteredCandidates(q, r, 'filtered')
        end
    end
end

size(evaluationResults)

plotEvaluationResults(evaluationResults, topCostPercents, numFiltIterations)