% ======================================================================
% This code written by R. Michael Winters & Siddharth Kumar
% Date created: March 13, 2016
%
%> @brief creates distance mats for all reference tracks vs. the query track
%> called by :: searchAllNonZeroFrames
%>
%> @param bestMatches = 3 x numRefTracks * numMatches to return with (winSize, frame, and
%> (dis)similarity)
%> @param distMatStruct = Full distmats for all reference and query 
%>
%> @retval costs = An array of costs
% ======================================================================

function  costs = determineCosts(bestMatches, qFrame, distMats, bigHopSize, bigWinSize, numMatchesToReturn, numHops)

% Run a DTW for these bestMatches
costs = zeros(1,size(bestMatches,2));

nonZeroIndx = find(bestMatches(1,:)>0);
% Search the top matches and return their data.
for k = nonZeroIndx;
    
    % Need the qStart, rStart, rWinSize
    [qStart, qEnd, ~] = computeStartEndFrame(qFrame, bigHopSize, bigWinSize+(numHops*bigHopSize)); 
%     qWinSize = bigWinSize;
%     qEnd = (2 * qWinSize - 1) + qStart;
    
    [rStart, rEnd, ~] = computeStartEndFrame(bestMatches(2, k), bigHopSize, bestMatches(1, k)+(numHops*bigHopSize));
%     rStart = (bestMatches(2, k) - 1) * 2 * bigHopSize + 1;
%     rWinSize = bestMatches(1, k);
%     rEnd = (2 * rWinSize - 1) + rStart;

    % Create your sub-distMat to search
    refTrackIdx = ceil(k / numMatchesToReturn); 
    eval(['subDistMat = distMats.r' num2str(refTrackIdx) '(qStart : qEnd, rStart : rEnd);']);

    % Return your cost and pathLength
    [cost, pathLength] = DTW_Cpp(subDistMat);
    
    % We devide cost by the pathlength, and apply a scaling factor of
    % pathLength/winSize, canceling out the pathLength.
    costs(k) = cost / (2 * bestMatches(1, k) - 1); 
end