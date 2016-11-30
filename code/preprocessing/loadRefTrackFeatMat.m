function refTracks = loadRefTrackFeatMat

load('Mvt1FeatMat.mat')
load('Mvt2FeatMat.mat')
load('Mvt3FeatMat.mat')
refTracks.Mvt1 = Mvt1;
refTracks.Mvt2 = Mvt2;
refTracks.Mvt3 = Mvt3;