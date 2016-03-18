% ======================================================================
% This code written by R. Michael Winters
% Date created: February 18, 2016
%
%> @brief searches for best matching reference track for all frames in a
%> query file.
%> called by ::
%>
%> @param qStruct: The struct of the query track, including all features,
%> and non-zeroFrames
%>
%> @retval results: A numNonZeroFrame block with best resulting track  
% ======================================================================
function results = searchAllNonZeroFrames(qStruct, rStruct)

% Do an error check. They should have the same bigWinSize and bigHopSize;
if qStruct.bigWinSize ~= rStruct.r1.bigWinSize
    error('BigWinSize is not the same between query and reference')
elseif qStruct.bigHopSize ~= rStruct.r1.bigHopSize
    error('BigWinSize is not the same between query and reference')
end
    
% Save the number of nonZeroFrames to search over
lenNZF = length(qStruct.nZF);

% Results will be the best distance and the track number 
results = zeros(3,lenNZF);

% The number of matches to return for each reference track
numMatchesToReturn = 15;

numRefTracks = size(rStruct.filenames,2);

% Best matches is filled with the 5 best results for each reference track
bestMatches = zeros( 3 , numMatchesToReturn * numRefTracks );

% Calculate distanceMats between complete, raw pC vectors
distMats = createDistMats(qStruct,rStruct);

for i = 1:lenNZF
    
%     [startFrame, endFrame, numFrames] = computeStartEndFrame(qStruct.nZF(i), qStruct.bigHopSize, qStruct.bigWinSize);
% 
%     % Because we zero-padded when we calculated nZF, there is a
%     % possibility, of frames that extend past the 
%     if endFrame >= size(qStruct.pC, 2)
%         qStruct.nZF(i) = 0;
%         break
%     end
        
    % Find the best numResultsToReturn for each reference track.
    for j = 1:numRefTracks

        % Generate a list of numMatchesToReturn for each referenceTrack. 
        eval(['bestMatches( : , (j-1) * numMatchesToReturn + 1 : j * numMatchesToReturn)' ...
            ' = searchForSimilarFrame(qStruct, qStruct.nZF(i), rStruct.r' num2str(j) ...
             ', numMatchesToReturn);']);
         
         % Output is winSize, frameNum in the reference, and distance
         % You know first numResultsToReturn is first track, then second,
         % etc.
    end
    
    % eval(['rNZF = rStruct.r' num2str(j) '.nZF;']);
    costs = determineCosts(bestMatches, qStruct.nZF(i), distMats, qStruct.bigHopSize, qStruct.bigWinSize, numMatchesToReturn);
    
    % Take the minimum of the costs
    % [val, idx] = min(costs);
    
    % Determine the wining frameNumber and referenceTrackIndx
    % Put frames with costs;
    
    % Select the best result
    [bestRefTrack, bestFrame, bestCost] = determineBestFrame(bestMatches(2,:), costs, numMatchesToReturn);
    
%     if bestRefTrack ~= 3
%         1+1
%     end
    
    results(:,i) = [bestRefTrack; bestFrame; bestCost];
    
end

% % What are dthe minima of the results?
% [mins, locs] = findMinima(results(3,:));
% 
% % Recover the index of the reference track.
% refTrackMins = results(1,locs);
% 
% % Get the q and r filenames
% qFilename = qStruct.filename;
% rFilenames = rStruct.filenames;

% It is possible that there will be no results (i.e. no NonZeroFrames)
if ~isempty(results)
    % Plot all of the values
    plotAllMins(results, qStruct, rStruct, numMatchesToReturn)
end





