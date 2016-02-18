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

% What are the frames that are without pauses? See removePauses.m
% nonZeroFrames = qStruct.nZF;
% lenNZF = length(nonZeroFrames);

% Initialize lengths and matrixes
matches = ones(3, numberOfMatches); % 1: qWinSize, 2: qFrame 3: dist
lenRef = length(rStruct.sC);
lenQry = length(qStruct.sC);

% Choose a frame from the Query, and find the minimum distance with all of
% the possible testVectors.

pdist2(rStruct.sC, qStruct.sC(qStruct.nZF))

% for i = 1 : lenNZF
%     sCSim = mae(qStruct.sC(i)
% 
% for i=1:(lengthTestVec-numOfBlocksToTest+1)
%    similarity = mae(mean(queryVec,2), mean(testVec(:,i:i+numOfBlocksToTest-1),2));
%    for j=1:numberOfMatches
%        if matches(2,j) > similarity
%            if j<numberOfMatches
%               matches((j+1:end),:) = matches(j:(end-1),:);
%            end     
%            matches(:,j) = [i; similarity];
%            break
%        end
%    end
% end
