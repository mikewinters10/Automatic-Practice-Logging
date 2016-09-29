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
function plotFilteredCandidates(qStruct, rStruct)

% Initialization
qFilename = qStruct.filename;
rFilenames = rStruct.filenames;
numResultsToReturn = qStruct.numMatchesToReturn;
numRefTracks = qStruct.numRefTracks;

% Choose the candidates for plotting
results = qStruct.filteredCandidates;

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
timesMat = repmat(times, numResultsToReturn, 1);

% Here we go! Full screen figure
figure('units','normalized','outerposition',[0 0 1 1])
set(gca,'fontsize',16)

hold on
for i = 1:numRefTracks
    subplot(3,4,i)
    
    % Get the indexes of the results that apply to this reference track
    indx = (i-1)*(numResultsToReturn)+1:i*numResultsToReturn;
    
    % Get the frame numbers for this reference track
    resultsForRefTrack = squeeze(results(2,indx,:));
    
    % WThe filtered candidates have zeros that need to be disregarded
    nonZeroIndx = find(resultsForRefTrack);
    
    % Do a scatter plot
    scatter(timesMat(nonZeroIndx), ...
        ( resultsForRefTrack(nonZeroIndx) -1 ) * framesToSecondsFactor)
   
    % Formatting
    title(rFilenames{i}) 
    xlabel('Query Time(s)')
    ylabel('Reference Time (s)')
    xlim([0 qStruct.duration]);
    
    % Reference track length
    refTrackLen = eval(['rStruct.r' num2str(i) '.duration']);
    ylim([0 refTrackLen])
    box on
end
hold off

[ax, q3] = suplabel(['Candidates for ' qStruct.filename ....
    ', Cost Threshold = ' num2str(qStruct.costThreshold) ...
    ', # Filter Iterations = ' num2str(qStruct.numFilterIterations)] ,'t'); 
set(q3, 'FontSize',20)

%%%% Save the figure in the appropriate place

[~, folderName, ~] = fileparts(qFilename); 

folderPath = ['Figures/' folderName];

if ~exist(folderPath)
    mkdir(folderPath);
end
timestamp = char(datetime('now','Format','yyyy-MM-dd''T''HHmmss'));

hgexport(gcf, [folderPath '/' timestamp '.png'],  hgexport('factorystyle'), 'Format', 'png');
