% This function takes the results and 
function stepwiseIncreasingResults = findStepwiseIncreasing(results3D, numMatchesToReturn)

stepwiseIncreasingResults = zeros(size(results3D));

numRefTracks = size(results3D,2)/numMatchesToReturn;

for l = 1:numRefTracks

    results = results3D(:,(l-1)*numMatchesToReturn+1:l*numMatchesToReturn,:);
    
    % For each nonzeroFrame
    for i = 1:size(results,3)-2
        for j = 1:size(results,2)
            candidateFrame      = results(2,j,i);
            for k = 1:size(results,2)
                futureFrame     = results(2,k,i+1); 
                % Only include it if three conditions are met:
                if futureFrame >= candidateFrame && futureFrame <= candidateFrame + 2 %&& results(1,j,i) == results(1,k,i+1)
                    stepwiseIncreasingResults(:,(l-1)*numMatchesToReturn+j,i) = results(:,j,i);
                end
            end
        end
    end
end
        