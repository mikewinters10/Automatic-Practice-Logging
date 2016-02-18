% ======================================================================
% This code written by R. Michael Winters
% Date created: February 16, 2016
%
%> @brief finds the most similar frames for a given query.
%> called by ::
%>
%> @param fs: The sampling rate of everything (assummed to be the same for
% query and reference
%>
%> @retval matches: Mvt1, Mvt2, Mvt3 structs containing structs of the
% different features
%>
% ======================================================================
function refStructs = saveRefFeatureMatrices(fs)

% Global winSizes and hopSizes
winSize = [0.5, 0.65, 0.80, 0.95, 1.1, 1.25];
hopSize = 0.25;

% Set them to inside-struct variable
Mvt1.winSize = winSize;
Mvt2.winSize = winSize;
Mvt3.winSize = winSize;
Mvt1.hopSize = hopSize;
Mvt2.hopSize = hopSize;
Mvt3.hopSize = hopSize;

% And the reference tracks
Mvt1.refTrack = 'Berman_Prokofiev_Op29_Mvt1.mp3';
Mvt2.refTrack = 'Berman_Prokofiev_Op29_Mvt2.mp3';
Mvt3.refTrack = 'Berman_Prokofiev_Op29_Mvt3.mp3';

% Create PC Matrixes for Reference1

[Mvt1.sC.sC1, Mvt1.pC.pC1] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(1), Mvt1.hopSize, fs);
[Mvt1.sC.sC2, Mvt1.pC.pC2] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(2), Mvt1.hopSize, fs);
[Mvt1.sC.sC3, Mvt1.pC.pC3] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(3), Mvt1.hopSize, fs);
[Mvt1.sC.sC4, Mvt1.pC.pC4] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(4), Mvt1.hopSize, fs);
[Mvt1.sC.sC5, Mvt1.pC.pC5] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(5), Mvt1.hopSize, fs);
[Mvt1.sC.sC6, Mvt1.pC.pC6] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(6), Mvt1.hopSize, fs);

save('Mvt1FeatMat', 'Mvt1')

% Create PC Matrixes for Reference2
[Mvt2.sC.sC1, Mvt2.pC.pC1] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(1), Mvt2.hopSize, fs);
[Mvt2.sC.sC2, Mvt2.pC.pC2] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(2), Mvt2.hopSize, fs);
[Mvt2.sC.sC3, Mvt2.pC.pC3] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(3), Mvt2.hopSize, fs);
[Mvt2.sC.sC4, Mvt2.pC.pC4] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(4), Mvt2.hopSize, fs);
[Mvt2.sC.sC5, Mvt2.pC.pC5] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(5), Mvt2.hopSize, fs);
[Mvt2.sC.sC6, Mvt2.pC.pC6] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(6), Mvt2.hopSize, fs);

save('Mvt2FeatMat', 'Mvt2')

% Create PC Matrixes for Reference3
[Mvt3.sC.sC1, Mvt3.pC.pC1] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(1), Mvt3.hopSize, fs);
[Mvt3.sC.sC2, Mvt3.pC.pC2] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(2), Mvt3.hopSize, fs);
[Mvt3.sC.sC3, Mvt3.pC.pC3] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(3), Mvt3.hopSize, fs);
[Mvt3.sC.sC4, Mvt3.pC.pC4] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(4), Mvt3.hopSize, fs);
[Mvt3.sC.sC5, Mvt3.pC.pC5] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(5), Mvt3.hopSize, fs);
[Mvt3.sC.sC6, Mvt3.pC.pC6] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(6), Mvt3.hopSize, fs);

save('Mvt3FeatMat', 'Mvt3')

refStruct.Mvt1 = Mvt1;
refStruct.Mvt2 = Mvt2;
refStruct.Mvt3 = Mvt3;