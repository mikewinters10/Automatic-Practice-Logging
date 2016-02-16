function playBlocks(inputAudio,startBlock,endBlock, hopSizeInSec, winSizeInSec, fs)

if ischar(inputAudio)
    fileName = inputAudio;
    inputAudio = audioread(inputAudio);
end

% If it has not been downmixed already, do that here.
if size(inputAudio,2) == 2
    inputAudio = downMix(inputAudio);
end

% Grab the desired section
inputAudio = extractBlocks(inputAudio,startBlock,endBlock, hopSizeInSec, winSizeInSec, fs);

% Play it
soundsc(inputAudio,fs)