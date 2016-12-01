% ======================================================================
% This code written by R. Michael Winters
% Date created: November 29, 2016
%
%> @brief : find the matching reference sections for Snipets
%> called by :: 
%>
%> @param filteredSegments : an array of structs representing the filtered
%           segments.
%>
%> @retval : the initial array of structs with a new field :
%       "snipetResults"
% =====================================================================

function segmentsWithSnipetResults = getSnipetResultsForSegments(filteredSegments)

% Give feedback to the user
disp('Getting snipet results for segment(s)')

% Get the results for all filtered segments
for i = 1:length(filteredSegments)
    qStruct = filteredSegments(i);
    
    % Retrieve the boundaries and the lengths of the snipets
    snipetStartEndArray     = returnSnipetBoundariesForSegment(qStruct);
    snipetLengths           = diff(snipetStartEndArray')+1;
    
    % Determine the snipet matches
    snipetMatches = zeros(1,size(snipetStartEndArray,1));
    for j = 1:length(snipetMatches)
        snipetMatches(j) = returnMatchingRefSectionForSnipet(qStruct, snipetStartEndArray(j,1), snipetStartEndArray(j,2));
    end

    % Save these to the segment struct
    qStruct.snipetResults.snipetStartEndArray  = snipetStartEndArray;
    qStruct.snipetResults.snipetLengths       = snipetLengths;
    qStruct.snipetResults.snipetMatches       = snipetMatches;
    
    % Using arrays of structs can be a little complicated.
    if i == 1
        segmentsWithSnipetResults = qStruct;
    else
        segmentsWithSnipetResults = [segmentsWithSnipetResults, qStruct];
    end
    
    % Give feedback to the user
    if mod(i,10) == 10
        disp(['Finished ' num2str(i) ' of ' num2str(length(filteredSegments)) '.'])
    end
    
end
        
