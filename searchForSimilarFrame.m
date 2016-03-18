% ======================================================================
% This code written by R. Michael Winters
% Date created: February 16, 2016
%
%> @brief finds the most similar frames for a given query.
%> called by ::
%>
%> @param queryStruct: A struct with spectral centroid, chroma, and non-zero
%frames
%> @param refStruct: A struct with spectral centroid, and chroma for a
%reference
%> @param numMatchesToReturn: A positive integer number of matches to return
%> @param frameToTest: The integer of the frame desired to search for.
%>
%> @retval matches: A 3 x numMatchesToReturn vector with refWinSize,
% framenumbers, distances 
% ======================================================================
function matches = searchForSimilarFrame(qStruct, frameToTest, rStruct, numMatchesToReturn)

% Number of versions we will search:
%numVersions = length(rStruct.winSizes);
winSizesToSearch = rStruct.winSizes;
numWins = length(winSizesToSearch);

% A number of minimums to return for each version independently (internal)
numResults = 10;

% An internal best results array
bestResults = zeros(3,numResults * numWins);

% Get the query frames to average together.
% numFramesToAvg = 2 * qWinSize - 1;
% startFrame = frameToTest * 8;
% qPCFrames = qStruct.pC(:, startFrame:(startFrame + numFramesToAvg - 1));

[startFrame, endFrame, numFrames] = computeStartEndFrame(frameToTest, qStruct.bigHopSize, qStruct.bigWinSize);


if endFrame <= size(qStruct.pC, 2)
    qPCFrames = qStruct.pC(:, startFrame : endFrame);
    qPC = sum(qPCFrames, 2) / numFrames;
else
    qPC = zeros(12,1);
end

% 
% if endFrame <= size(qStruct.pC, 2)
%     qPCFrames = qStruct.pC(:, startFrame : endFrame);
%     qPC = sum(qPCFrames, 2) / numFrames;
% else
%     qPC = zeros(12,1);
% end

% For all of the iterations of pC (e.g. pC1, pC2)
for k=1:numWins

    % Load the referencePC for this winSize
    eval(['rPC = rStruct.w' num2str(k) '.pC;']);
    
    % Calculate the Euclidean Distance
    distance = pdist2(qPC', rPC'); 
    
    % Keep only the best numResults
    [val, idx] = sort(distance);
    
    % numResults per window Size. Put them into a vector.
    places = ((k-1)*numResults+1):k*numResults;
    bestResults(:,places) =                             ...
        [ rStruct.winSizes(k) * ones(1, numResults);       ...
          rStruct.nZF(idx(1:numResults));               ...
          val(1:numResults)];
end
    
% Now find best results across all versions
[~, idx] = sort(bestResults(3,:));
matches = bestResults(:,idx(1:numMatchesToReturn));