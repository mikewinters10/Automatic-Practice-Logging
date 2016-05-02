% % ======================================================================
% % This code written by R. Michael Winters
% % Date created: April 30, 2016
% %
% %> @brief Plots all candidates for a given struct
% %> called by :: searchAllNonZeroFrames
% %>
% %> @param fullResultsArray: The full results of min values
% %> @param minValueVec: A 3 x numMinVals vector of the 
% %>
% 
% % ======================================================================
function plotCandidates(qStruct)

qFilename = qStruct.filename;
rFilenames = {'Op.29, Mvt.1', 'Op.29, Mvt.2', 'Op.29, Mvt.3'};

numResultsToReturn = qStruct.numMatchesToReturn;

%resultsMins = qStruct.results(2,:);
results = qStruct.candidates;

% Determine times in seconds
% Convert non-zero Frames to seconds;
sampleRate = 44100; % Shoot! Not global yet.
framesToSecondsFactor = qStruct.bigHopSize * qStruct.winSize / sampleRate;
times = (qStruct.nZF-1)*framesToSecondsFactor;

%sizeMinValVec = size(minValVec,2);

figure

% Plot Frame over time
%subplot(1,2,1)

%%%%%%% MARKERS %%%%%%%%%
mkrSize = 10;
mkrWidth = 1.6;
% Make a handle for each reference track
h = zeros(3,1);
% 
% Convert resultsMins to seconds:
%resultsMins = resultsMins * framesToSecondsFactor;

numRefTracks = length(results(1,:,1))/numResultsToReturn;

for i = 1:numRefTracks
    subplot(1,3,i)
    indx = (i-1)*(numResultsToReturn)+1:i*numResultsToReturn;
    hold on
    for j = 1:length(qStruct.nZF);
        nonZeroIndx = [];
        nonZeroIndx = find(results(2,indx,j));
        if ~isempty(nonZeroIndx) 
            for k = nonZeroIndx
                if i == 1
                    h(1) = scatter3(times(j), results(2,indx(k),j)*framesToSecondsFactor, results(1,indx(k),j), 'r+');
                elseif i == 2
                    h(2) = scatter3(times(j), results(2,indx(k),j)*framesToSecondsFactor, results(1,indx(k),j), 'go');
                elseif i == 3
                    h(3) = scatter3(times(j), results(2,indx(k),j)*framesToSecondsFactor, results(1,indx(k),j), 'm*');
                end
            end
        end
    end
    title(['Op. 29, Mvt. ' num2str(i) ])
    xlabel('Time(s)')
    ylabel('Match (s)')
    zlabel('Frame Length')
    box on
    hold off
end

[ax, h3] = suplabel(['Candidates for ' qStruct.filename ', Filter Iteration: 0'] ,'t'); 
set(h3, 'FontSize',14)

%saveas(gcf, 'Figures/Step0.eps', 'epsc');
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', ['Candidates for ' qStruct.filename ' no Reduction'], ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center',...
%     'FontSize', 20 , ...
%     'FontWeight', 'Bold')
%linkaxes([h(1),h(2),h(3)])

% 
% %%%%%%% LINE %%%%%%%%%
% % Use splitvec to separate unconsecutive frames
% discont = SplitVec(qStruct.nZF,'consecutive');
% for i = 1:length(discont)
%     vals = resultsMins(ismember(qStruct.nZF , discont{i} ) ) * framesToSecondsFactor;
%     idxs = (discont{i} - 1)*framesToSecondsFactor;
%     plot( idxs , vals , 'Color', [0.5  0.5  1]);
%     hold on
% end
% 
% xlabel('Time (s)')
% ylabel('Match (s)')
% 
% %%%%%%% MARKERS %%%%%%%%%
% mkrSize = 10;
% mkrWidth = 1.6;
% % Make a handle for each reference track
% h = zeros(3,1);
% % 
% 
% % Convert resultsMins to seconds:
% resultsMins = resultsMins * framesToSecondsFactor;
% 
% for i = 1:length(resultsMins);
%     if results(1,i) == 1
%         h(1) = plot(times(i), resultsMins(i), 'r+','MarkerSize',mkrSize, 'LineWidth', mkrWidth);
%     elseif results(1,i) == 2
%         h(2) = plot(times(i), resultsMins(i), 'go','MarkerSize',mkrSize, 'LineWidth', mkrWidth);
%     elseif results(1,i) == 3
%         h(3) = plot(times(i), resultsMins(i), 'm*','MarkerSize',mkrSize, 'LineWidth', mkrWidth);
%     end
% end
% 
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
%             h(1) = plot(i, results(3,i),'r+','MarkerSize',mkrSize, 'LineWidth', mkrWidth,'Visible','off');
%         elseif i == 2
%             h(2) = plot(i, results(3,i),'go','MarkerSize',mkrSize, 'LineWidth', mkrWidth,'Visible','off');
%         elseif i == 3
%             h(3) = plot(i, results(3,i),'m*','MarkerSize',mkrSize, 'LineWidth', mkrWidth, 'Visible','off');
%         end
%     end
% end
% 
% 
% %%%%%%% LEGEND %%%%%%%%%
% % Prepend these results to the rFilenames to add to the legend
% for i = 1:size(rFilenames,2)
%     rFilenames{i} = [num2str(c(i)) ' ' rFilenames{i}];
% end
% 
% a = legend(h, rFilenames);
% 
% %%%%%%% TITLE %%%%%%%%%
% if isfield(qStruct,'annotation')
%     title(['Best Matches for ' qFilename ' (Annotation: "' qStruct.annotation '")'])
% else
%     title(['Best Matches for ' qFilename ' (Thresh = ' num2str(qStruct.threshold) ', numDTW = ' num2str(numResultsToReturn*3) ')'])
% end
% 
% % [~, fname] = fileparts(qFilename);
% % htitle = ['Figures/' fname '.eps'];
% % saveas(gcf, htitle,'epsc');