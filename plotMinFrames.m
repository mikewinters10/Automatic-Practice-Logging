% % ======================================================================
% % This code written by R. Michael Winters
% % Date created: February 16, 2016
% %
% %> @brief Plots all minimum values by color for each reference track.
% %> called by :: searchAllNonZeroFrames
% %>
% %> @param fullResultsArray: The full results of min values
% %> @param minValueVec: A 3 x numMinVals vector of the 
% %>
% 
% % ======================================================================
function plotMinFrames(qStruct)

qFilename = qStruct.filename;
rFilenames = {'Op.29, Mvt.1', 'Op.29, Mvt.2', 'Op.29, Mvt.3'};

numResultsToReturn = 15;

resultsMins = qStruct.results(2,:);
results = qStruct.results;

% Convert non-zero Frames to seconds;
times = (qStruct.nZF-1)/8;

%sizeMinValVec = size(minValVec,2);

figure

%%%%%%% LINE %%%%%%%%%
% Use splitvec to separate unconsecutive frames
discont = SplitVec(qStruct.nZF,'consecutive');
for i = 1:length(discont)
    vals = resultsMins(ismember(qStruct.nZF , discont{i} ) );
    idxs = (discont{i} - 1) / 8;
    plot( idxs , vals , 'Color', [0.5  0.5  1]);
    hold on
end

xlabel('Time (s)')
ylabel('Matching Frame')

%%%%%%% MARKERS %%%%%%%%%
mkrSize = 10;
mkrWidth = 1.6;
% Make a handle for each reference track
h = zeros(3,1);
% 
for i = 1:length(resultsMins);
    if results(1,i) == 1
        h(1) = plot(times(i), resultsMins(i), 'r+','MarkerSize',mkrSize, 'LineWidth', mkrWidth);
    elseif results(1,i) == 2
        h(2) = plot(times(i), resultsMins(i), 'go','MarkerSize',mkrSize, 'LineWidth', mkrWidth);
    elseif results(1,i) == 3
        h(3) = plot(times(i), resultsMins(i), 'm*','MarkerSize',mkrSize, 'LineWidth', mkrWidth);
    end
end

% Count all of the minima in each example
[a, b] = hist(results(1,:), unique(results(1,:)));
c = zeros(1,length(rFilenames));
c(b) = a;

% For dealing with cases that there is 0 matches
if size(a,2) <  length(rFilenames)
    c = zeros(1,length(rFilenames));
    c(b) = a;
    for i = find(c==0)
        if i == 1
            h(1) = plot(i, results(3,i),'r+','MarkerSize',mkrSize, 'LineWidth', mkrWidth,'Visible','off');
        elseif i == 2
            h(2) = plot(i, results(3,i),'go','MarkerSize',mkrSize, 'LineWidth', mkrWidth,'Visible','off');
        elseif i == 3
            h(3) = plot(i, results(3,i),'m*','MarkerSize',mkrSize, 'LineWidth', mkrWidth, 'Visible','off');
        end
    end
end


%%%%%%% LEGEND %%%%%%%%%
% Prepend these results to the rFilenames to add to the legend
for i = 1:size(rFilenames,2)
    rFilenames{i} = [num2str(c(i)) ' ' rFilenames{i}];
end

a = legend(h, rFilenames);

%%%%%%% TITLE %%%%%%%%%
if isfield(qStruct,'annotation')
    title(['Best Matches for ' qFilename ' (Annotation: "' qStruct.annotation '")'])
else
    title(['Best Matches for ' qFilename ' (Thresh = ' num2str(qStruct.threshold) ', numDTW = ' num2str(numResultsToReturn*3) ')'])
end

% % Count all of the minima in each example
% [a, b] = hist(results(1,:), unique(results(1,:)));
% c = zeros(1,length(rFilenames));
% c(b) = a;
% 
% % For dealing with cases that there is 0 matches
% if size(a,2) <  length(rFilenames)
%     c = zeros(1,length(rFilenames));
%     c(b) = a;
%     for i = find(c==0)
%         if i == 1
%             h(1) = plot(i, results(2,i),'r+','MarkerSize',mkrSize, 'LineWidth', mkrWidth,'Visible','off');
%         elseif i == 2
%             h(2) = plot(i, results(2,i),'go','MarkerSize',mkrSize, 'LineWidth', mkrWidth,'Visible','off');
%         elseif i == 3
%             h(3) = plot(i, results(2,i),'m*','MarkerSize',mkrSize, 'LineWidth', mkrWidth, 'Visible','off');
%         end
%     end
% end
% 
% 
% hold off
% 
% % Format the plot
% box on
% 
% % Prepend these results to the rFilenames to add to the legend
% for i = 1:size(rFilenames,2)
%     rFilenames{i} = [num2str(c(i)) ' ' rFilenames{i}];
% end
% 
% a = legend(h,rFilenames);
% 
% xlabel('Non-Zero Frame')
% ylabel('(Dis) Similarity')
% 
% % If there is an annotation, put it in the title.
% if isfield(q,'annotation')
%     title(['Best Matches for ' qFilename ' ("' q.annotation '," Thresh = ' num2str(q.threshold) ', numDTW = ' num2str(numResultsToReturn*3) ')'])
% else
%     title(['Best Matches for ' qFilename ' (Thresh = ' num2str(q.threshold) ', numDTW = ' num2str(numResultsToReturn*3) ')'])
% end
% hold off
% 
% [~, fname] = fileparts(qFilename);
% htitle = ['Figures/' fname '.eps'];
% saveas(gcf, htitle,'epsc');