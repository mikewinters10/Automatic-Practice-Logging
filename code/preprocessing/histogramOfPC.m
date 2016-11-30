function histogramOfPC(pcMatrix, startBlock, endBlock)

% Get the desired blocks
block = pcMatrix(:,startBlock:endBlock);

% Take the mean of the blocks
block = mean(block,2);