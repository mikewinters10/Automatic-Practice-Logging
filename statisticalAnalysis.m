fs = 44100;

stats = struct;
stats.numRepFiles = 0;
stats.repTime = 0;
stats.numMvt1 = 0;
stats.mvt1Time = 0;
stats.numMvt2 = 0;
stats.mvt2Time = 0;
stats.numMvt3 = 0;
stats.mvt3Time = 0;
stats.numSRFiles = 0;
stats.srTime = 0;
stats.numTechFiles = 0;
stats.techTime = 0;
stats.numImpFiles = 0;
stats.impTime = 0;

annotations = dir('APL_Dataset/All Annotations/*.tsv');

for j = 1:length(annotations); 
    
    disp(['Searching ' annotations(j).name '...'])
    a = tdfread(['APL_Dataset/All Annotations/' annotations(j).name],'\t');
    
    for i = 1:size(a.Filename,1)
        lenFile = size(audioread(a.Filename(1,:)),1)/fs;

        if strcmp(strtrim(a.Type(i,:)), 'Repertoire');
            stats.numRepFiles = stats.numRepFiles + 1;
            stats.repTime =  stats.repTime + lenFile;

            if strcmp(strtrim(a.Descriptor_1(i,:)), 'Prokofiev')

                if strcmp(strtrim(a.Descriptor_2(i,:)), 'Op. 29, Mvt. 1')
                    if strcmp(strtrim(a.Start_Time(i,:)),'') 
                        stats.numMvt1 = stats.numMvt1 + 1;
                        stats.mvt1Time = stats.mvt1Time + lenFile;
                    end
                elseif strcmp(strtrim(a.Descriptor_2(i,:)), 'Op. 29, Mvt. 2')
                    if strcmp(strtrim(a.Start_Time(i,:)),'') 
                        stats.numMvt2 = stats.numMvt2 + 1;
                        stats.mvt2Time = stats.mvt2Time + lenFile;
                    end
                elseif strcmp(strtrim(a.Descriptor_2(i,:)), 'Op. 29, Mvt. 3')
                    if strcmp(strtrim(a.Start_Time(i,:)),'') 
                        stats.numMvt3 = stats.numMvt3 + 1;
                        stats.mvt3Time = stats.mvt3Time + lenFile;
                    end

                end
            end

        elseif strcmp(strtrim(a.Type(i,:)), 'Sight-Reading')
            stats.numSRFiles = stats.numSRFiles + 1;
            stats.srTime = stats.srTime + lenFile;

        elseif strcmp(strtrim(a.Type(i,:)), 'Technique')

            stats.numTechFiles = stats.numTechFiles + 1;
            stats.techTime = stats.techTime + lenFile;
            
        elseif strcmp(strtrim(a.Type(i,:)), 'Improvisation')
            stats.numImpFiles = stats.numImpFiles + 1;
            stats.impTime = stats.impTime + lenFile;
        end
    end
end
        
