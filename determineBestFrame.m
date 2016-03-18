% ======================================================================
% This code written by R. Michael Winters & Siddharth Jumar
% Date created: March 13, 2016
%
%> @brief creates distance mats for all reference tracks vs. the query track
%> called by :: searchAllNonZeroFrames
%>
%> @param frames = Of the best matches
%> @param costs = arry of scaled costs from the DTW
%> param numMatchesToReturn = numMatchesToReturn for each reference track
%>
%> @retval frameNum = The best matching frame number
%> @retval refTrack = The indx of the reference track for the match
%> @retval cost = The cost for this value.
% ======================================================================

function [bestRefTrack, bestFrame, bestCost] = determineBestFrame(frames, preCosts, numMatchesToReturn)

numRefTracks = length(frames)/numMatchesToReturn;

% Apply a function that weights costs depending upon number of repeated
% frames
%costs = weightedCost(frames, preCosts, numMatchesToReturn);
costs = preCosts;

% Sort best costs, and get their indexes
[vals, idx] = sort(costs);

% What are the corresponding reference indexes?
winIndx = ceil(idx(1:5)/numMatchesToReturn);

% Code from: http://www.mathworks.com/matlabcentral/answers/19042-finding-duplicate-values-per-column
uniqueIdx = unique(winIndx);
countOfIdx = hist(winIndx,uniqueIdx);

% If there is only one unique value, we can have special considerations
if length(uniqueIdx) ~= 1
    indexToRepeatedValue = (countOfIdx ~= 1);
    repeatedValues = uniqueIdx(indexToRepeatedValue);
else
    repeatedValues = uniqueIdx;
end
% numberOfAppearancesOfRepeatedValues = countOfIdx(indexToRepeatedValue);

% If there is only one repeated values, easily determine the best frame

if length(repeatedValues) == 1
    
    % Get the first repeated value and use it.
    indx2 = find(winIndx==repeatedValues,1,'first');
    
    % Get the corresponding best cost, frame, and reference track.
    bestCost = costs(idx(indx2));
    bestFrame = frames(idx(indx2));
    bestRefTrack = ceil(idx(indx2)/numMatchesToReturn);
    
% Do something else entirely if there are more than one repeated Values
elseif length(repeatedValues) > 1
    
    % For each of the repeated values
    for i = 1:length(repeatedValues) 
        
        % Test each one independently
        test = repeatedValues(i);
        indx2 = find(winIndx == test);
        
        % We take the mean of the best cost (as if they are referring
        % to the same frame), though we can't do this without more info.
        if i == 1;    
            bestCost = mean(vals(indx2));
            bestFrame = frames(min(indx2)); 
            bestRefTrack = ceil(idx(min(indx2))/numMatchesToReturn);
        elseif mean(vals(indx2)) < bestCost
            bestCost = mean(vals(indx2));
            bestFrame = frames(min(indx2));
            bestRefTrack = ceil(idx(min(indx2))/numMatchesToReturn);
        end
    end
    
% If there are no repeated values, then just take the first result
elseif isempty(repeatedValues)
    bestCost = vals(1);
    bestFrame = frames(idx(1));
    bestRefTrack = ceil(idx(1)/numMatchesToReturn);
end