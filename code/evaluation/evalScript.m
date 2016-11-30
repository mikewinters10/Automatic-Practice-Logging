% ======================================================================
% This code written by R. Michael Winters
% Date created: November 29, 2016
%
%> @brief : analyze all snipets in the annotated segments.
%> called by :: 
%>
%> @param qStruct : the full struct of the practice segment. Assumes
%       filtering has already occured
%>
%> @retval : 
% =====================================================================

fullResults = load('fullResults')
    

% Filter these candidates to include the most likely
q = filterCandidates(q, numFilterIterations, topPercentageOfCandidates);

% Sum try to predict the correct reference track number
matchingRefTrack = returnMatchingRefTrackForCandidates(q);

% Display the results
disp(['CostThreshold: ' num2str(topCostPercents(k)) '. Filter Iterations:' num2str(numFiltIterations(j))]);
%disp(['Annotation: ' q.inputAudioStruct.section '--- Result: ' num2str(matchingRefTrack)]);
%disp('');

% Create a 4-D matrix with one confusion matrix per j and k
evaluationResults(j,k,str2double(q.inputAudioStruct.section(9:end)), matchingRefTrack) = ...
    evaluationResults(j,k,str2double(q.inputAudioStruct.section(9:end)), matchingRefTrack) + 1;


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