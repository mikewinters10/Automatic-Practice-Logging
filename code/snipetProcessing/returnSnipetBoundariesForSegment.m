% ======================================================================
% This code written by R. Michael Winters
% Date created: November 29, 2016
%
%> @brief : determine the snipet start and end indexes for a given segment
%> called by :: getSnipetResultsForSegment.m
%>
%> @param qStruct : the segment struct, containing non-zero frames (.nZF)
%>
%> @retval : an Nx2 array of start and end boundaries
% =====================================================================

function snipetStartEndArray = returnSnipetBoundariesForSegment(qStruct)

% Determine the start indexes
startIndx   = find([1 diff(qStruct.nZF)>1]);
endIndx     = find([diff(qStruct.nZF)>1 1]);

% Use these to determine the start and ends of the array
snipetStartEndArray = [qStruct.nZF(startIndx)',qStruct.nZF(endIndx)'];