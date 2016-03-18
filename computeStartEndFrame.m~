% ======================================================================
% This code written by R. Michael Winters
% Date created: March 16, 2016
%
%> @brief computes the start and end frame of a finely sampled vector for
%  given bigHopSize and bigWinSize
%> called by :: searchAllNonZeroFrames
%>
%> @param startIdx = the startFrame of the big vector
%> @param bigHopSize = the bigHopSize factor
%> @param bigWinSize = the bigWinSize factor
%> 
%> @retval startFrame = the startFrame for the finely sampled vector
%> @retval endFrame = the endFrame of the finely sampled vector
%>
%> @retval costs = An array of costs
% ======================================================================

function [startFrame, endFrame, numFrames] = computeStartEndFrame(bigFrame, bigHopSize, bigWinSize)

% In this context, this function is called in order to average many frames
% together
numFrames = 2 * bigWinSize - 1;
            
% Compute start and end frames
startFrame = ((bigFrame - 1) * 2 * bigHopSize ) + 1;
endFrame = startFrame + numFrames - 1;