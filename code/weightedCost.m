function weightedCosts = weightedCost(frames, costs, numMatchesToReturn)

% Initialize weighted cost
weightedCosts = zeros(size(costs));

% Take the distance matrix for all of the frames
frameDist = pdist2(frames',frames');

% Binarize to those close and those far:
frameDist = frameDist < 5;

% Get the number of reference tracks:
numRefTracks = length(frames) / numMatchesToReturn;

% Perform an operation for identifying repeats, tallying them, and reducing cost because of it. 
for i = 1:numRefTracks
    
    % Create an index vector 
    indx = ((i-1)*numMatchesToReturn+1 : i*numMatchesToReturn);
    
    % Define the frameDistance submatrix
    mat = frameDist(indx, indx);
    
    % Find the number of unique rows
    uniqueRows = unique(mat,'rows');
    
    % If there are any repeats, you may lower the cost
    if size(uniqueRows,1) < numMatchesToReturn
        
        % Remove the unique rows without any repeats
        uniqueRows = uniqueRows(sum(uniqueRows,2) > 1,:);
        
        % Now, for each of the repeats, you can apply the weighting
        for j = 1:size(uniqueRows,1)
            
            % Get the index of the repeats
            matchIdx = ismember(mat,uniqueRows(j,:),'rows');
            
            % Use those indexes to reduce the cost factor
            weightedCosts(indx(matchIdx)) = costs(indx(matchIdx))/sum(matchIdx);
        end    
    end
end