% Use only the input vectors for which the the threshold exceed the probability

function [nonZeroFrames, processed] = removePauses(x, thresh, probability)

% Binarize the matrix 
binary = gt(abs(x),thresh);
lenBin = length(binary(:,1));

% Plot the binarization
% figure;
% imagesc(binary)
% title('Binarization of the Input Vector') 

% Initialize processed vector as the same size as input
processed = zeros(size(x));
nonZeroFrames = zeros(1, size(x,2));

% A for loop to make a new matrix with zeros for values below the threshold
for i = 1:size(binary,2)
    if sum(binary(:,i)) > (lenBin * probability);
        processed(:,i) = x(:,i);
        nonZeroFrames(i) = i;
    end
end

% Remove them.
nonZeroFrames(nonZeroFrames==0)=[];

% figure;
% imagesc(gt(abs(processed),thresh))
% title('Output Vector Binarization (throw away all pauses)')

% Only use the ones that are not zeros
% processed( :, ~any(processed,1) ) = [];  %columns