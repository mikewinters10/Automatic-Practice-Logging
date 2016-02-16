function audioVector = extractBlocks(audioVector,startBlock,endBlock, hopSizeInSec, winSizeInSec, fs)

audioVector = audioVector((startBlock * hopSizeInSec * fs) : ((endBlock * hopSizeInSec + winSizeInSec)*fs))';