% ======================================================================
% This code written by R. Michael Winters
% Date created: November 29, 2016
%
%> @brief : find the matching reference sections for Snipets
%> called by :: 
%>
%> @param qStruct : the full struct of the practice segment. Assumes
%       filtering has already occured
%>
%> @retval : 
% =====================================================================

function getSnipetResultsForSegment(qStruct)
    
% Retrieve the boundaries and the lengths of the snipets
snipetStartEndArray = returnSnipetBoundariesForSegment(qStruct);
snipetLengths = diff(snipetStartEndArray')+1;

% For each of the snipets, find the match
snipetMatches = int16.empty(size(snipetStartEndArray,1));
for j = 1:length(snipetMatches)
    snipetMatches(j) = returnMatchingRefSectionForSnipet(q, snipetStartEndArray(j,1), snipetStartEndArray(j,2));
end

% Save these to a reference struct
qStruct.snipetResults.snipeStartEndArray  = snipetStartEndArray;
qStruct.snipetResults.snipetLengths       = snipetLengths;
qStruct.snipetResults.snipetMatches       = snipetMatches;
        
