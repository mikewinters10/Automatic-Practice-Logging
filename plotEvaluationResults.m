% A function to plot and save a confusionMatrix with user defined title

function plotEvaluationResults(evaluationResults, topCostPercents, numFilterIterations)

figure('units','normalized','outerposition',[0 0 1 1]);

plotIdx = 1;
for i = 1:length(topCostPercents)
    for j = 1:length(numFilterIterations)
        confusionMatrix = squeeze(evaluationResults(i,j,:,:));
        
        accuracy = trace(confusionMatrix) / sum(sum(confusionMatrix));
        
        titleStr = [num2str(round(accuracy,2)*100) '% accuracy. ' ...
            'Num. iter.: ' num2str(numFilterIterations(j)) ...
            '. Top ' num2str(topCostPercents(i)*100) '% costs.'];

        % Do a subplot of the results
        subplot(length(topCostPercents),length(numFilterIterations), plotIdx);
        imagesc(confusionMatrix);
        plotIdx = plotIdx + 1;
        title(titleStr)
        ylabel('Annotated Track');
        xlabel('Matching Track');
    end
end

%% Save the figure to the right directory
timestamp = char(datetime('now','Format','HHmmss'));
today = char(datetime('now','Format','yyyy-MM-dd'));

folderPath = ['Figures/' today];

if ~exist(folderPath)
    mkdir(folderPath);
end

% hgexport(gcf, [folderPath '/' whichKind '_' timestamp '.png'],  hgexport('factorystyle'), 'Format', 'png');
hgexport(gcf, ['Figures/' today '/' timestamp '.png'],  hgexport('factorystyle'), 'Format', 'png');
end