% A function that finds the matching track names for a particular movement
% on a particular day
% 
% R. Michael Winters September 27, 2016
function matches = findMatchingTracksForMvtAndDate(movementNumber, date)

%tracks = dir(['APL_Dataset/' date '/*.mp3'])
annotation = tdfread(['APL_Dataset/' date '/' date ' - Sheet1.tsv']);

% Initialize the cell
cellIdx = 0;
matches = cell(cellIdx);

% Find all of the track names that are only one track 
for i = 1:length(annotation.Filename)
    
    % If the file name is the desired movement number
    if strcmp(strtrim(annotation.Descriptor_2(i,:)),['Op. 29, Mvt. ' num2str(movementNumber)])
        
        % If the Start Time is empty
        if strcmp(strtrim(annotation.Start_Time(i,:)),'')
            
            % Add the file name to a cell, which will be returned
            cellIdx = cellIdx + 1;
            matches(cellIdx) = {annotation.Filename(i,:)};
        end
    end
end