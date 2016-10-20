function struct = createFeatureMatrixFromSection(inputAudioStruct, bigHopSize, bigWinSize, removeSilence)

if nargin < 4
    removeSilence = true;
end

% Declare global variables
winSize = 4096;
hopSize = 2048;
fs      = 44100;

% Add reference information to struct
struct.filename = inputAudioStruct.trackName;
struct.inputAudioStruct = inputAudioStruct;
struct.hopSize  = hopSize;
struct.winSize  = winSize;
struct.fs       = fs;

% Add the important user-defined big hopSize and winSize
struct.bigHopSize   = bigHopSize;
struct.bigWinSize   = bigWinSize;

startTimeInSec = inputAudioStruct.startSec;
endTimeInSec = inputAudioStruct.endSec;

% Do pre-processing.
inputAudio  = processInputAudio(inputAudioStruct.trackName, fs, startTimeInSec, endTimeInSec);

% Save duration in seconds:
struct.duration = length(inputAudio)/fs;

% To check for nonZeroFrames, we take longer chunks
winSizeNZF  = bigWinSize * winSize;
hopSizeNZF  = bigHopSize * winSize;

% Remove silence from the clip. For reference tracks, this should be done
% elsewhere.
if removeSilence == true
    
    % Block the audio to compute nonZeroFrames
    xNZF    = blockAudio(inputAudio, winSizeNZF, hopSizeNZF);
   
    % Our blockAudio function zero-padded, so we zeroPad now as well.
    inputAudio = [zeros( ceil( winSizeNZF / 2 ) , 1) ; inputAudio ; zeros( ceil( winSizeNZF / 2 ) , 1 )];

    % Use only the blocks for which the sample values exceed the 'threshold,' 'probability' percent of the time.
    threshold = 0.02; % 0.005 is a good value %0.05 is agressive.
    probability = 0.5; % Probability threshold for number of zeros after thresholding per window
    [struct.nZF, struct.zF, ~] = removePauses(xNZF, threshold, probability);
    
    struct.threshold = threshold;
    struct.probability = probability;

    % Play through the zeroFrames if desired
%     for i = 1:size(zeroFrames)
%         playBlock(inputAudio, startBlock, winSize, hopSize, bigHopSize, bigWinSize, fs)
%     end
else
    % If we are not removing silences, your nZF is everything.
    struct.nZF = 1:length([ 1 : hopSizeNZF : size(inputAudio,1) ]);
end

% Change the nZF to the same reference point as the normal track
% struct.nZF = struct.nZF * 8;

% % Now take the fully blocked and hopSized audio for pitch chroma analysis
x = blockAudio(inputAudio, winSize, hopSize);  

% Take the magnitude of the fft
% X = abs(fft(x)); 

% Use only the first half
% X = X(1:winSize/2,:);

Y = abs(spectrogram(inputAudio, winSize, winSize/2));

struct.pC = pitchChroma(Y,fs);
struct.sC = spectralCentroid(Y,fs);

struct.pC = [struct.pC];

%savePitchChromaMatrix(pC, fileName)