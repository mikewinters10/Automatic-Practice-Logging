function generateFeatureMatrixes

% And the reference tracks
pcRef1_0 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt1.mp3',0.75,0.25,fs);
pcRef1_1 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt1.mp3',1,0.25,fs);
pcRef1_2 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt1.mp3',1.25,0.25,fs);
pcRef1_3 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt1.mp3',1.5,0.25,fs);
pcRef1_4 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt1.mp3',1.75,0.25,fs);
pcRef1_5 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt1.mp3',2,0.25,fs);

d



pcRef2_0 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt2.mp3',0.75,0.25,fs);
pcRef2_1 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt2.mp3',1,0.25,fs);
pcRef2_2 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt2.mp3',1.25,0.25,fs);
pcRef2_3 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt2.mp3',1.5,0.25,fs);
pcRef2_4 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt2.mp3',1.75,0.25,fs);
pcRef2_5 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt2.mp3',2.0,0.25,fs);

pcRef3_0 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt3.mp3',0.75,0.25,fs);
pcRef3_1 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt3.mp3',1,0.25,fs);
pcRef3_2 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt3.mp3',1.25,0.25,fs);
pcRef3_3 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt3.mp3',1.5,0.25,fs);
pcRef3_4 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt3.mp3',1.75,0.25,fs);
pcRef3_5 = createPitchChromaMatrix('Berman_Prokofiev_Op29_Mvt3.mp3',2.0,0.25,fs);

% Save them if desired:
savePitchChromaMatrix(pCQuery, filename)
