function saveRefFeatureMatrixes(fs)

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
[Mvt1.sc0, Mvt1.pc0] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(1), Mvt1.hopSize, fs);
[Mvt1.sc1, Mvt1.pc1] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(2), Mvt1.hopSize, fs);
[Mvt1.sc2, Mvt1.pc2] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(3), Mvt1.hopSize, fs);
[Mvt1.sc3, Mvt1.pc3] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(4), Mvt1.hopSize, fs);
[Mvt1.sc4, Mvt1.pc4] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(5), Mvt1.hopSize, fs);
[Mvt1.sc5, Mvt1.pc5] = createFeatureMatrix(Mvt1.refTrack, Mvt1.winSize(6), Mvt1.hopSize, fs);

save('Mvt1FeatMat', 'Mvt1')

% Create PC Matrixes for Reference2
[Mvt2.sc0, Mvt2.pc0] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(1), Mvt2.hopSize, fs);
[Mvt2.sc1, Mvt2.pc1] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(2), Mvt2.hopSize, fs);
[Mvt2.sc2, Mvt2.pc2] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(3), Mvt2.hopSize, fs);
[Mvt2.sc3, Mvt2.pc3] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(4), Mvt2.hopSize, fs);
[Mvt2.sc4, Mvt2.pc4] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(5), Mvt2.hopSize, fs);
[Mvt2.sc5, Mvt2.pc5] = createFeatureMatrix(Mvt2.refTrack, Mvt2.winSize(6), Mvt2.hopSize, fs);

save('Mvt2FeatMat', 'Mvt2')

% Create PC Matrixes for Reference3
[Mvt3.sc0, Mvt3.pc0] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(1), Mvt3.hopSize, fs);
[Mvt3.sc1, Mvt3.pc1] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(2), Mvt3.hopSize, fs);
[Mvt3.sc2, Mvt3.pc2] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(3), Mvt3.hopSize, fs);
[Mvt3.sc3, Mvt3.pc3] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(4), Mvt3.hopSize, fs);
[Mvt3.sc4, Mvt3.pc4] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(5), Mvt3.hopSize, fs);
[Mvt3.sc5, Mvt3.pc5] = createFeatureMatrix(Mvt3.refTrack, Mvt3.winSize(6), Mvt3.hopSize, fs);

save('Mvt3FeatMat', 'Mvt3')
