function struct = createFeatureMatrix(inputAudio, winSizeInSec, hopSizeInSec, fs)

% Add reference information to struct
struct.filename = inputAudio;
struct.winSize = winSizeInSec;
struct.hopSize = hopSizeInSec;
struct.fs = fs;

% Do pre-processing.
inputAudio = processInputAudio(inputAudio,fs);

% Block audio according to desired window and hopSize
x = blockAudio(inputAudio, winSizeInSec, hopSizeInSec, fs);

% Use only the blocks for which the sample values exceed the 'threshold,' 'probability' percent of the time.
threshold = 0.01; % 0.005 is a good value %0.05 is agressive.
probability = 0.5; % Probability of being zero
[struct.nZF, x] = removePauses(x, threshold, probability);

% Take the magnitude of the fft
X = abs(fft(x)); 

% Use only the first half
X = X(1:fs/2,:);

struct.pC = pitchChroma(X,fs);
struct.sC = spectralCentroid(X,fs);

%savePitchChromaMatrix(pC, fileName)