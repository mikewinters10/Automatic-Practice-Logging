% ======================================================================
% This code written by R. Michael Winters
% Date created: March 15, 2016
%
%> @brief Extract the samples a given startBlock refers to. 
%>
%> @param audioVector   = a Nx1 array of audio samples
%> @param startBlock    = The index of the bigWindow the user wants to extract
%> @param frameSize     = The internal (small) window size (e.g. 4096)
%> @param hopSize       = The internal (small) hop size (e.g. 2048)
%> @param bigHopFactor  = The user-defined (big) hop factor (e.g. 4, meaning 4 * the frameSize ) 
%> @param bigWinFactor  = The user-defined (big) window size (e.g. 32,
%  meaning 32 * frameSize) 
%>
%> @retval audioVector  = The audio for the desired startBlock
%> @retval startSample  = The start sample of the block
%> @retval endSample    = The end sample for the block
% ======================================================================

function [audioVector, startSample, endSample] = extractBlock(inputAudio, startBlock, winSize, hopSize, bigHopSize, bigWinSize)

startSample = ((startBlock-1) * (bigHopSize * hopSize)) + 1;
endSample = startSample + (bigWinSize * winSize);

audioVector = inputAudio(startSample : endSample)';