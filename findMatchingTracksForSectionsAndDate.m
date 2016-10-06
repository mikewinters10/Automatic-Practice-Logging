% A function that finds the matching sections and tracks for a particular movement
% on a particular day.
% 
% R. Michael Winters September 27, 2016
function matches = findMatchingTracksForSectionsAndDate(movementNumber, date)

%tracks = dir(['APL_Dataset/' date '/*.mp3'])
annotation = tdfread(['APL_Dataset/' date '/' date '-Sections - Sheet1.tsv']);

% Initialize the cell
cellIdx = 0;
matches = cell(cellIdx);

% Find all of the track names that are only one track 
for i = 1:length(annotation.Filename)
    
    % If the file name is the desired movement number
    if strcmp(strtrim(annotation.Descriptor_2(i,:)),['Op. 29, Mvt. ' num2str(movementNumber)])
        
        % Initialize start and end time
        t.trackName = strtrim(annotation.Filename(i,:));
        t.section= strtrim(annotation.Descriptor_3(i,:));
        t.other = strtrim(annotation.Other(i,:));
        
        % Convert times to seconds
        startTime = strsplit(strtrim(annotation.Start_Time(i,:)),':');
        t.startSec = (str2num(startTime{1})*60+str2num(startTime{2}));
        endTime = strsplit(strtrim(annotation.End_Time(i,:)),':');
        t.endSec = (str2num(endTime{1})*60+str2num(endTime{2}));
        
        % Put these results into a struct
        cellIdx = cellIdx + 1;
        matches(cellIdx) = {t};
    end
end