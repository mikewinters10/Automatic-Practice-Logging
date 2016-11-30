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
function plotFilteredCandidates(qStruct, rStruct, whichKind)

if nargin <=2
    whichKind = 'filtered';
end

% Initialization
qFilename = qStruct.filename;
rFilenames = rStruct.filenames;
numMatchesToReturn = qStruct.numMatchesToReturn;
numRefTracks = qStruct.numRefTracks;

% Choose the candidates for plotting
switch whichKind 
    case 'filtered'
        results = qStruct.filteredCandidates;
    case 'DTWs'
        results = qStruct.DTWs;
    case 'raw'
        results = qStruct.allCandidates;
end

% Convert non-zero frames to seconds;
sampleRate = 44100; % Shoot! Not global yet.
framesToSecondsFactor = qStruct.bigHopSize * qStruct.winSize / sampleRate;
times = (qStruct.nZF-1)*framesToSecondsFactor;

%%%%%%% MARKERS %%%%%%%%%
% mkrSize = 10;
% mkrWidth = 1.6;

% Make a handle for each reference track
h = zeros(numRefTracks,1);

% Create a times matrix
timesMat = repmat(times, numMatchesToReturn, 1);

% Here we go! Full screen figure
figure('units','normalized','outerposition',[0 0 1 1])
set(gca,'fontsize',16)

% To color our scatter plot according to cost, you need to figure out max
% and min costs;
costs = squeeze(results(3,:,:));
maxCost = max(max(costs));
% Currently "zeros" are placeholders, and need to be disregarded when
% computing the min
costs(costs <= 0) = inf; 
minCost= min(min(costs));

% Convert the current colormap
% colormap jet

hold on
for i = 1:numRefTracks
    subplot(3,4,i)
    
    % Get the indexes of the results that apply to this reference track
    indx = (i-1)*(numMatchesToReturn)+1:i*numMatchesToReturn;
    
    % Get the frame numbers for this reference track
    resultsForRefTrack  = squeeze(results(2,indx,:));
    costsForRefTrack    = squeeze(results(3,indx,:));
    
    % WThe filtered candidates have zeros that need to be disregarded
    nonZeroIndx = find(resultsForRefTrack);
    
    % Do a scatter plot
    scatter(timesMat(nonZeroIndx), ...
        ( resultsForRefTrack(nonZeroIndx) -1 ) * framesToSecondsFactor, [], ...
        convertCostsToColors(costsForRefTrack(nonZeroIndx), minCost, maxCost))
   
    % Formatting
    title(rFilenames{i}) 
    xlabel('Query Time(s)')
    ylabel('Reference Time (s)')
    xlim([0 qStruct.duration]);
    
    % Reference track length
    refTrackLen = eval(['rStruct.r' num2str(i) '.duration']);
    ylim([0 refTrackLen])
    box on
        % Create a rectangle around zero-frames:
    yLims = ylim;
    % Grey: 'FaceColor',[0.9 0.9 0.9], 
    for j = qStruct.zF
        xPos = j * framesToSecondsFactor;
        rectangle('Position', [xPos 0 framesToSecondsFactor yLims(2)],...
            'FaceColor',[0.9 0.9 0.9],'EdgeColor','none')
    end
end
hold off

% Get the annotation if available
if isfield(qStruct.inputAudioStruct, 'section')
    section = qStruct.inputAudioStruct.section;
else
    section = '';
end;

[ax, q3] = suplabel(['Candidates for ' qStruct.filename ....
    ', Cost Threshold = ' num2str(qStruct.costThreshold) ...
    ', # Filter Iterations = ' num2str(qStruct.numFilterIterations) ...
    ' (Annotation = ' section ')'] ,'t'); 
set(q3, 'FontSize',20)

% Give a chance for the figure to update
pause(1)
%%%% Save the figure in the appropriate place

[~, folderName, ~] = fileparts(qFilename); 

timestamp = char(datetime('now','Format','HHmmss'));
today = char(datetime('now','Format','yyyy-MM-dd'));

folderPath = ['Figures/' today];

if ~exist(folderPath)
    mkdir(folderPath);
end

% hgexport(gcf, [folderPath '/' whichKind '_' timestamp '.png'],  hgexport('factorystyle'), 'Format', 'png');
hgexport(gcf, ['Figures/' today '/' folderName '_' whichKind '_' timestamp '.png'],  hgexport('factorystyle'), 'Format', 'png');
end

% Figure out color scaling factor:
function colorValues = convertCostsToColors(costs, minCost, maxCost)
   % Scale the range to 1 to 10
    colorValues = (((costs - minCost) / maxCost) * 19) + 1;
end