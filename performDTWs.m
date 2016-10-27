% A function to perform DTWs on Filtered Candidates
function qStruct = performDTWs(qStruct, rStruct)

% Calculate the distance matrices
distMats = createDistMats(qStruct, rStruct);

% Retrieve variables
numRefTracks = qStruct.numRefTracks;
numMatchesToReturn = qStruct.numMatchesToReturn;
filteredCandidates = qStruct.filteredCandidates;

% Create output format for the results: ([winSize, frame, DTWCost,
% DTWPathLength]')
DTWs = zeros(4, size(filteredCandidates,2),size(filteredCandidates,3));
DTWs(1:2,:,:) = filteredCandidates(1:2,:,:);


% For every non-zero frame in the query track
for j = 1:size(qStruct.nZF);
 
    % Retrieve the query frame, and the start/end block:
    queryFrame = qStruct.nZF(j);
    [qStart, qEnd, ~] = computeStartEndFrame(queryFrame, qStruct.bigHopSize, qStruct.bigWinSize); 
    
    % Find the filtered candidates frames,  winsizes, and indexes.
    candidateFrames = qStruct.filteredCandidates(2,:,j);
    candidateWinSizes = qStruct.filteredCandidates(1,:,j);
    candidateIndx = find(candidateFrames);
    
    % Perform the DTW for all of the candidate indexes
    for k = candidateIndx
        
        % Get start and end block for the reference track
        [rStart, rEnd, ~] = computeStartEndFrame(candidateFrames(k), rStruct.bigHopSize, candidateWinSizes(k));
        
        % Figure out the reference track
        refTrackIdx = ceil(k / numMatchesToReturn);
        
        % Retrieve the correct distance matrix
        eval(['subDistMat = distMats.r' num2str(refTrackIdx) '(qStart : qEnd, rStart : rEnd);']);  
        
        % Get the costs
        [cost, pathLength] = DTW_Cpp(subDistMat);
        
        % Add them to the DTW array.
        DTWs(3:4,k,j) = [cost pathLength]';
    end
 
end

qStruct.DTWs = DTWs;

% function deriveFinalCostFromDTWCostandPathLength(cost,pathLength,winSize)
%     
% end
% 
% for i=1:numRefTracks
%     % Get the indexes of the results that apply to this reference track
%     indx = (i-1)*(numMatchesToReturn)+1:i*numMatchesToReturn;
%     
%     % Get candidate frames of reference track
%     candidateFrames = filteredCandidates(2,indx,:);
%     
%     % Get the indexes of the filtered candidates
%     nonZeroIndx = find(candidateFrames);
%     
%     
% end

% % Run a DTW for these bestMatches
% costs = zeros(1,size(bestMatches,2));
% 
% nonZeroIndx = find(bestMatches(1,:)>0);
% % Search the top matches and return their data.
% for k = nonZeroIndx;
%     
%     % Need the qStart, rStart, rWinSize
%     [qStart, qEnd, ~] = computeStartEndFrame(qFrame, bigHopSize, bigWinSize+(numHops*bigHopSize)); 
% %     qWinSize = bigWinSize;
% %     qEnd = (2 * qWinSize - 1) + qStart;
%     
%     [rStart, rEnd, ~] = computeStartEndFrame(bestMatches(2, k), bigHopSize, bestMatches(1, k)+(numHops*bigHopSize));
% %     rStart = (bestMatches(2, k) - 1) * 2 * bigHopSize + 1;
% %     rWinSize = bestMatches(1, k);
% %     rEnd = (2 * rWinSize - 1) + rStart;
% 
%     % Create your sub-distMat to search
%     refTrackIdx = ceil(k / numMatchesToReturn); 
%     eval(['subDistMat = distMats.r' num2str(refTrackIdx) '(qStart : qEnd, rStart : rEnd);']);
% 
%     % Return your cost and pathLength
%     [cost, pathLength] = DTW_Cpp(subDistMat);
%     
%     % We devide cost by the pathlength, and apply a scaling factor of
%     % pathLength/winSize, canceling out the pathLength.
%     costs(k) = cost / (2 * bestMatches(1, k) - 1); 
% end