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
function qStruct = searchAllNonZeroFrames(qStruct, rStruct)

% Do an error check. They should have the same bigWinSize and bigHopSize;
if qStruct.bigWinSize ~= rStruct.r1.bigWinSize
    error('BigWinSize is not the same between query and reference')
elseif qStruct.bigHopSize ~= rStruct.r1.bigHopSize
    error('BigWinSize is not the same between query and reference')
end
    
% Save the number of nonZeroFrames to search over
lenNZF = length(qStruct.nZF);

% The number of matches to return for each reference track
numMatchesToReturn = 60;
qStruct.numMatchesToReturn = numMatchesToReturn;

numRefTracks = size(rStruct.filenames,2);
qStruct.numRefTracks = numRefTracks;

% Results will be the best distance and the track number 
results = zeros(3,lenNZF);

% Create a new results array allowing comparison across multiple NZFs
candidates = zeros(3, numRefTracks*numMatchesToReturn, lenNZF);

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
    %costs = determineCosts(bestMatches, qStruct.nZF(i), distMats, qStruct.bigHopSize, qStruct.bigWinSize, numMatchesToReturn);
    
    % Take the minimum of the costs
    % [val, idx] = min(costs);
    
    % Determine the wining frameNumber and referenceTrackIndx
    % Put frames with costs;
    
    %stepwiseIncreasingResults = findStepwiseIncreasing([bestMatches(1:2,:); costs], numMatchesToReturn);
    
    % Select the best result
    %[bestRefTrack, bestFrame, bestCost] = determineBestFrame(bestMatches(2,:), costs, numMatchesToReturn);
    
%     if bestRefTrack ~= 3
%         1+1
%     end
    
    % Doing this will allow us to compare across different frames
    candidates(:,:,i) = bestMatches;

    % ORIGINAL: ISMIR 2015
    % results(:,i) = [bestRefTrack; bestFrame; bestCost];
    
end

% Save candidates to your struct;
qStruct.allCandidates = candidates;

numFilterIterations = 5; 

for i = 1:numFilterIterations
    candidates = findStepwiseIncreasing(candidates, numMatchesToReturn);
end

qStruct.candidates = candidates;

% Perform the DTW on the costs
for i = 1:lenNZF
    i
    % Perform a DTW on the result
    costs = determineCosts(candidates(:,:,i), qStruct.nZF(i), distMats, qStruct.bigHopSize, qStruct.bigWinSize, numMatchesToReturn, numFilterIterations);
    %[bestRefTrack, bestFrame, bestCost] = determineBestFrame(bestMatches(2,:), costs, numMatchesToReturn);
    % For now just take the minimum
    bestCost = min(costs(costs>0));
    
    if bestCost > 0
        indx = find(costs==bestCost);

        % Use the minimum to compute bestRefTrack and bestFrame
        bestRefTrack = ceil(indx / numMatchesToReturn);
        bestFrame = candidates(2,indx,i);

        % Window length is also available, but won't be used at the moment.
        bestWindowLength = candidates(1,indx,i);

        % Save these to the results array
        results(:,i) = [bestRefTrack; bestFrame; bestCost];
    end
end

% Make it so that all of the elements between have points that exist
discont = SplitVec(qStruct.nZF,'consecutive');
newResults = results;
for i=1:length(discont)
    indx = ismember(qStruct.nZF , discont{i} );
    vals = results(:,indx);
    likelyRefTrack = mode(vals(vals(1,:)>0)); % Pick the reference track using majority vote
    likelyPosition = median(vals(2,vals(2,:)>0));
    % Find all of the values that do not match the reference track
    
    reconsiderIndx = find(ismember(qStruct.nZF, discont{i}(find(vals(1,:)~=likelyRefTrack | abs(vals(2,:)-likelyPosition)>(length(discont{i})/2)))));
    
    results(:,reconsiderIndx);
    % Go and find the ones that are from a nearby frame and then have the
    % least cost
    for j = reconsiderIndx
        % Use it to query the possible candidates
        possibilities = qStruct.allCandidates(:,(likelyRefTrack-1)*numMatchesToReturn+1:likelyRefTrack*numMatchesToReturn,j);
       % Use only frames are those that are close to the mode
        possibleFrames = abs(possibilities(2,:)-likelyPosition)<(length(discont{i})/2);
        if any(possibleFrames)
            % Pick the frame where the cost is the least
            [~, idx] = min(abs(possibilities(2,possibleFrames)-likelyPosition));
            fullVec = possibilities(:,possibleFrames);
            newResults(:,j) = [likelyRefTrack; fullVec(2:3,idx)];
        else
            newResults(:,j) = [0; 0; 0];
        end
    end
    newResults(:,reconsiderIndx)
end


qStruct.results = newResults;
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
% if ~isempty(results) && size(results,2) > 5
%     % Plot all of the values
%    % plotAllMins(results, qStruct, numMatchesToReturn)
% end





