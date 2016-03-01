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

numRefTracks = size(rStruct.filenames,2);

% Best matches is filled with the 5 best results for each reference track
bestMatches = zeros( numRefTracks , numMatchesToReturn * numRefTracks );

for i = 1:lenNZF
    for j = 1:numRefTracks
        i
        eval(['bestMatches(:,(j-1)*numMatchesToReturn+1:j*numMatchesToReturn)'...
            ' = searchForSimilarFrame(qStruct, qStruct.nZF(i), rStruct.r' ...
             num2str(j) ', numMatchesToReturn);']);
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
end

% What are the minima of the results?
[mins, locs] = findMinima(results(2,:));

% Recover the index of the reference track.
refTrackMins = results(1,locs);

% Get the q and r filenames
qFilename = qStruct.filename;
rFilenames = rStruct.filenames;

% Plot all of the values
plotAllMins(results,[refTrackMins; locs; mins], qFilename, rFilenames);





