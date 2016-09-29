% The purpose of this function is to use contextual information to remove 
% Matches that are "unlikely." An unlikely match refers to a frame that is 
% isolated---having nearby frames before or after.
%
% Called by findAllCandidates.m
function stepwiseIncreasingResults = findStepwiseIncreasingCandidates(candidates, numRefTracks)

stepwiseIncreasingResults = zeros(size(candidates));

for l = 1:numRefTracks

    results = candidates(:,(l-1)*numRefTracks+1:l*numRefTracks,:);
    
    % For each nonzeroFrame
    for i = 1:size(results,3)-2
        for j = 1:size(results,2)
            candidateFrame      = results(2,j,i);
            for k = 1:size(results,2)
                futureFrame     = results(2,k,i+1); 
              
                % Only include it if certain conditions are met:
                if futureFrame > candidateFrame && futureFrame <= candidateFrame + 2 %&& results(1,j,i) == results(1,k,i+1)
                    stepwiseIncreasingResults(:,(l-1)*numRefTracks+j,i) = results(:,j,i);
                end
            end
        end
    end
end
        