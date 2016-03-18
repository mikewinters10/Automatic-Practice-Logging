function playBlock(startBlock, struct, plotTrue)

inputAudio = struct.filename;
hopSize = struct.hopSize;
winSize = struct.winSize;
bigHopSize = struct.bigHopSize;
bigWinSize = struct.bigWinSize;
fs = struct.fs;


if ischar(inputAudio)
    fileName = inputAudio;
    inputAudio = audioread(inputAudio);
end

% If it has not been downmixed already, do that here.
if size(inputAudio,2) == 2
    inputAudio = downMix(inputAudio);
end

% Grab the desired section
inputAudio = extractBlock(inputAudio, startBlock, winSize, hopSize, bigHopSize, bigWinSize);

if plotTrue
    plot(inputAudio)
end

% Play it
soundsc(inputAudio,fs)