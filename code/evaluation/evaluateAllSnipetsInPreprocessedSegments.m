% ======================================================================
% This code written by R. Michael Winters
% Date created: November 29, 2016
%
%> @brief : filter and guess best 
%> called by :: 
%>
%> @param qStruct : the full struct of the practice segment. Assumes
%       filtering has already occured
%>
%> @retval : 
% =====================================================================

function evaluateAllSnipetsInPreprocessedSegments(preprocessedSegments)
    
filteredSegments =  filterCandidatesInAllPreProcessedSegments(preprocessedSegments);

snipetResultsForSegments = getSnipetResultsForSegments(filteredSegments);

% Create a 4-D matrix with one confusion matrix per j and k
evaluationResults(j,k,str2double(q.inputAudioStruct.section(9:end)), matchingRefTrack) = ...
    evaluationResults(j,k,str2double(q.inputAudioStruct.section(9:end)), matchingRefTrack) + 1;
