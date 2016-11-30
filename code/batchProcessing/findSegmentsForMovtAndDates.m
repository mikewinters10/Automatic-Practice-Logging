% A function that finds the matching sections and tracks for a particular movement
% on a particular day.
% 
% R. Michael Winters September 27, 2016
function snipets = findSegmentsForMovtAndDates(movementNumber, dates)

% Annotations go here
annotation = struct;

%tracks = dir(['APL_Dataset/' date '/*.mp3'])
for i = 1:length(dates)
    fileResults = tdfread(['APL_Dataset/' dates{i} '/' dates{i} '-Sections - Sheet1.tsv']);
    if i == 1
        annotation = fileResults;
    else
        annotation = [annotation, fileResults];
    end
end

% Initialize the cell
cellIdx = 0;
snipets = cell(cellIdx);

% Find all of the track names that are only one track
for j = 1:length(dates)
    for i = 1:length(annotation(j).Filename)

        % If the file name is the desired movement number
        if strcmp(strtrim(annotation(j).Descriptor_2(i,:)),['Op. 29, Mvt. ' num2str(movementNumber)])

            % Initialize start and end time
            t.trackName = strtrim(annotation(j).Filename(i,:));
            t.section= strtrim(annotation(j).Descriptor_3(i,:));
            t.other = strtrim(annotation(j).Other(i,:));

            % Convert times to seconds
            startTime = strsplit(strtrim(annotation(j).Start_Time(i,:)),':');
            t.startSec = (str2num(startTime{1})*60+str2num(startTime{2}));
            endTime = strsplit(strtrim(annotation(j).End_Time(i,:)),':');
            t.endSec = (str2num(endTime{1})*60+str2num(endTime{2}));

            % Put these results into a struct
            cellIdx = cellIdx + 1;
            snipets(cellIdx) = {t};
        end
    end
end