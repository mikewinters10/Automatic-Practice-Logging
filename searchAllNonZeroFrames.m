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
function results = searchAllNonZeroFrames(qStruct,rStruct)

% Save the number of nonZeroFrames to search over
lenNZF = length(qStruct.nZF);

% Results will be the best distance and the track number 
results = zeros(2,lenNZF);

numMatchesToReturn = 5;

numRefTracks = 5;

% Best matches is filled with the 5 best results for each reference track
bestMatches = zeros( 3 , numMatchesToReturn * length(fieldnames(rStruct)) );

for i = 1:lenNZF
    i
    bestMatches(:,1:5) = searchForSimilarFrame(qStruct, qStruct.nZF(i), rStruct.Mvt1,numMatchesToReturn);
    bestMatches(:,6:10) = searchForSimilarFrame(qStruct, qStruct.nZF(i), rStruct.Mvt2,numMatchesToReturn);
    bestMatches(:,11:15) = searchForSimilarFrame(qStruct, qStruct.nZF(i), rStruct.Mvt3,numMatchesToReturn);
    
    % Find the minimum (only one right answer for now)
    [val, idx] = min(bestMatches(3,:));

    if idx <= 5
        results(:,i) = [1;val];
    elseif idx <= 10
        results(:,i) = [2;val];
    elseif idx <= 15
        results(:,i) = [3;val];
    end   
end

% What are the minima of the results?
[mins, locs] = findMinima(results(2,:));

% Recover the index of the reference track.
refTrackMins = results(1,locs);

% Plot all of the values
plotAllMins(results(2,:),[refTrackMins; locs; mins]);





