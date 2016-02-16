function savePitchChromaMatrix(pC, filename)

[filename_separated, delimiter] = strsplit(filename,'.');
filename_without_extension = filename_separated{1}; 

save([filename_without_extension '_PC'],'pC');