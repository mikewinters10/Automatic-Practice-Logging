function [sC, pC, nonZeroFrames] = createFeatureMatrix(inputAudio, windowSizeInSec, hopSizeInSec, fs)

% Remove last eight-seconds
inputAudio = processInputAudio(inputAudio,fs);

% Block audio according to desired window and hopSize
x = blockAudio(inputAudio, windowSizeInSec, hopSizeInSec, fs);

% Use only the blocks for which the sample values exceed the 'threshold,' 'probability' percent of the time.
threshold = 0.01; % 0.005 is a good value %0.05 is agressive.
probability = 0.5; % Probability of being zero
[nonZeroFrames, x] = removePauses(x, threshold, probability);

% Take the magnitude of the fft
X = abs(fft(x)); 

% Use only the first half
X = X(1:fs/2,:);

pC = pitchChroma(X,fs);
sC = spectralCentroid(X,fs);

%savePitchChromaMatrix(pC, fileName)