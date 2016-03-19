% A function to do large-scale evaluation of frames 
function results = genConfMat(dateStr, r)

tic

disp(['Reading ' dateStr '...'])

% Generate internal variables;
bigHopSize = r.r1.bigHopSize;
bigWinSize = r.r1.bigWinSize;

% Parse the file
a = tdfread(['APL_Dataset/' dateStr '/' dateStr ' - Sheet1.tsv'],'\t');

% Initialize
j=0;

% Only use repertoire practice of prokofiev without an start or end times.
for i = 1:size(a.Filename,1)
    if strcmp(strtrim(a.Type(i,:)), 'Repertoire');
        if strcmp(strtrim(a.Descriptor_1(i,:)), 'Prokofiev')
            if strcmp(strtrim(a.Start_Time(i,:)),'') 
                j = j + 1;
                cellMatch{j,1} = strtrim(a.Filename(i,:));
                cellMatch{j,2} = strtrim(a.Descriptor_2(i,:));
            end
        end
    end
end

disp([num2str(size(cellMatch,1)) ' tracks to search.'])

% Save the reference matrix
results.refStruct = r;

% This is the switch telling createFeatureMatrix to ignore all 'Zero Frames'
removeSilence = true;

% Initialize Results
results.r1 = [];
results.r2 = [];
results.r3 = [];

for i = 1:size(cellMatch,1)
    q = createFeatureMatrix(cellMatch{i,1}, bigHopSize, bigWinSize, removeSilence);
    
    disp(['Searching ' cellMatch{i,1} ': ' num2str(length(q.nZF)) ' frames (' cellMatch{i,2} ').'])
    q.results = searchAllNonZeroFrames(q,r);
    q.annotation = cellMatch{i,2}; % Print to command window
    eval(['results.q' num2str(i) '= q;'])
    
    % Put the results in their own separate place for later
    %eval(['annotation = results.q' num2str(i) '.annotation;']);
    if      strcmp(q.annotation, 'Op. 29, Mvt. 1')
        eval(['results.r1 = [results.r1 results.q' num2str(i) '.results(1,:)];']);
    elseif  strcmp(q.annotation, 'Op. 29, Mvt. 2')
        eval(['results.r2 = [results.r2 results.q' num2str(i) '.results(1,:)];']);
    elseif  strcmp(q.annotation, 'Op. 29, Mvt. 3')
        eval(['results.r3 = [results.r3 results.q' num2str(i) '.results(1,:)];']);
    end
    
    % Create a new variable with the string
    eval(['r_' dateStr '=results;'])

    % Save it
    save(['Results/' dateStr '.mat'], ['r_' dateStr])
end

% for i = 1:size(cellMatch,1)
% 
% for i = 1:(length(fieldnames(results))-3)
%     eval(['annotation = results.q' num2str(i) '.annotation;']);
%     if strcmp(annotation, 'Op. 29, Mvt. 1')
%         eval(['results.r1 = [results.r1 results.q' num2str(i) '.results(1,:)];']);
%     elseif strcmp(annotation, 'Op. 29, Mvt. 2')
%         eval(['results.r2 = [results.r2 results.q' num2str(i) '.results(1,:)];']);
%     elseif strcmp(annotation, 'Op. 29, Mvt. 3')
%         eval(['results.r3 = [results.r3 results.q' num2str(i) '.results(1,:)];']);
%     end
% end

% Create confusion matrix
confusionMat = zeros(3,3);

if ~isempty(results.r1)
    confusionMat(1,1) = sum(results.r1==1);
    confusionMat(1,2) = sum(results.r1==2);
    confusionMat(1,3) = sum(results.r1==3);
end

if ~isempty(results.r2)
    confusionMat(2,1) = sum(results.r2==1);
    confusionMat(2,2) = sum(results.r2==2);
    confusionMat(2,3) = sum(results.r2==3);
end

if ~isempty(results.r3)
    confusionMat(3,1) = sum(results.r3==1);
    confusionMat(3,2) = sum(results.r3==2);
    confusionMat(3,3) = sum(results.r3==3);
end

% Add the confusion matrix to the results;
results.confusionMat = confusionMat;

% Create a new variable with the string
eval(['r_' dateStr '=results;'])

% Save it
save(['Results/' dateStr '.mat'], ['r_' dateStr])

toc
    