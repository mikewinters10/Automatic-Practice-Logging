% The purpose of this function is to use contextual information to remove 
% Matches that are "unlikely." An unlikely match refers to a frame that is 
% isolated---having nearby frames before or after.
%
% Called by filterCandidates.m
function stepwiseIncreasingResults = findStepwiseIncreasingCandidates(candidates, numRefTracks)

% Begin with empty results.
stepwiseIncreasingResults = zeros(size(candidates));

% Retrieve number of matches per reference file
numMatchesToReturn = size(candidates,2) / numRefTracks;

for l = 1:numRefTracks

    % Check the results for the particular reference track
    results = candidates(:,(l-1)*numMatchesToReturn+1:l*numMatchesToReturn,:);
    
    % For each nonzeroFrame
    for i = 1:size(results,3)-2
        for j = 1:size(results,2)
            candidateFrame      = results(2,j,i);
            for k = 1:size(results,2)
                futureFrame     = results(2,k,i+1); 
              
                % Only include it if certain conditions are met:
                if futureFrame > candidateFrame && futureFrame <= candidateFrame + 2 %&& results(1,j,i) == results(1,k,i+1)
                    stepwiseIncreasingResults(:,(l-1)*numMatchesToReturn+j,i) = results(:,j,i);
                    stepwiseIncreasingResults(:,(l-1)*numMatchesToReturn+k,i+1) = results(:,k,i+1);
                end
            end
        end
    end
end
        