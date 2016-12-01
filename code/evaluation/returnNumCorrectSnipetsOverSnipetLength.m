% ======================================================================
% This code written by R. Michael Winters
% Date created: November 28, 2016
%
%> @brief : Evaluate snipets and return the number correct versus length
%> called by :: 
%>
%> @param segmentsWithSnipetResults : a struct of preprocessed segments
%    that have been filtered.
%>
%> @retval resultsForUniqueSnipetLengths: a 3xN array of snipet lengths,
%number correct, and total number of snipets
% ======================================================================

function resultsForUniqueSnipetLengths = returnNumCorrectSnipetsOverSnipetLength(segmentsWithSnipetResults)

snipetResults       = int16.empty(1,0);
snipetLengths       = int16.empty(1,0);
snipetAnnotations   = int16.empty(1,0);

for i = 1:length(segmentsWithSnipetResults)
    % Get the snipet results
    for j = 1:length(segmentsWithSnipetResults(i).snipetResults.snipetMatches)
        snipetResults       = [snipetResults, segmentsWithSnipetResults(i).snipetResults.snipetMatches(j)];
        snipetLengths       = [snipetLengths, segmentsWithSnipetResults(i).snipetResults.snipetLengths(j)];
        snipetAnnotations   = [snipetAnnotations, str2num(segmentsWithSnipetResults(i).inputAudioStruct.section(9:end))];
    end
end

% What are the unique snipet lengths?
uniqueSnipetLengths = unique(snipetLengths);
lenUSL              = length(uniqueSnipetLengths); 

% Create an array for number of correct and total answers
resultsForUniqueSnipetLengths = zeros(3, lenUSL);

% Populate the first row with the unique snipet lengths
resultsForUniqueSnipetLengths(1,:) = uniqueSnipetLengths;

% Which snipet results match the annotation?
elementsTheSame = (snipetResults == snipetAnnotations);

for i = 1:lenUSL 
    searchIndx      = find(snipetLengths == uniqueSnipetLengths(i));
    
    % Total number of snipets correctly identified
    resultsForUniqueSnipetLengths(2,i) = sum(elementsTheSame(searchIndx));
    
    % Total number of snipets of this length:
    resultsForUniqueSnipetLengths(3,i) = length(searchIndx);
end