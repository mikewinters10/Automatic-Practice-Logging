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
numVersions = length(fieldnames(rStruct.pC));

% A number of minimums to return for each version independently (internal)
numResults = 10;

% An internal best results array
bestResults = zeros(3,numResults*numVersions);

% Take the desired frame to test from the struct
qPC = qStruct.pC(:,frameToTest);
qSC = qStruct.sC(:,frameToTest);

% For all of the iterations of pC (e.g. pC1, pC2)
for k=1:numVersions
    
    % save the desired reference pitchChroma and extractits length.
    eval(['rPC = rStruct.pC.pC' num2str(k) ';']);
    lenRPC = length(rPC);
    eval(['rSC = rStruct.sC.sC' num2str(k) ';']);
    lenRPC = length(rSC);
    
    % Calculate the Euclidean Distance
    distance = pdist2(qPC', rPC'); 
    
    % Find local minimum
    invDist = max(distance) - distance; 
    [pks, locs] = findpeaks(invDist);
    minimums = max(distance) - pks; 
    
    % Keep only the best numResults
    [val, idx] = sort(minimums);
    places = ((k-1)*numResults+1):k*numResults;
    bestResults(:,places) = ...
        [ rStruct.winSize(k)*ones(1,numResults); ...
          locs(idx(1:numResults));               ...
          val(1:numResults)];
end
    
% Now find best results across all versions
[~, idx] = sort(bestResults(3,:));
matches = bestResults(:,idx(1:numMatchesToReturn));