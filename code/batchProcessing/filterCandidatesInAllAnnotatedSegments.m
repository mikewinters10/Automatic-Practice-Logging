% ======================================================================
% This code written by R. Michael Winters
% Date created: November 28, 2016
%
%> @brief : run candidate filtering on a struct of all annotated segments 
%> called by :: 
%>
%> @param allAnnotatedSegments: An array of structs representing the
%       segments. Candidates have already been calculated 
%>
%> @retval allFilteredSegments: The original array of structs that have
%been filtered
% ======================================================================

function allFilteredSegments = filterCandidatesInAllAnnotatedSegments(allAnnotatedSegments)

% Specify the filter parameters
topPercentageOfCosts = 0.05;
spatialFilterSteps = 1;

% Give feedback to the user
disp('Filtering candidates in all segments');

for i = 1:length(allAnnotatedSegments)
   
    % Filter the candidates
    qStruct = filterCandidates(allAnnotatedSegments(i),spatialFilterSteps,topPercentageOfCosts);
    
    % Adding fields to arrays of structures is a little complicated.
    if i == 1
        allFilteredSegments = qStruct;
    else
        allFilteredSegments = [allFilteredSegments, qStruct];
    end
    
    % Give some feedback to the user
    if mod(i,10) == 0
        disp(['Done ' num2str(i) ' of ' num2str(length(allAnnotatedSegments)) '.']);
    end
end