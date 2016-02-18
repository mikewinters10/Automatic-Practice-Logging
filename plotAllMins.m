% ======================================================================
% This code written by R. Michael Winters
% Date created: February 16, 2016
%
%> @brief Plots all minimum values by color for each reference track.
%> called by :: searchAllNonZeroFrames
%>
%> @param fullResultsArray: The full results of min values
%> @param minValueVec: A 3 x numMinVals vector of the 
%>

% ======================================================================

function plotAllMins(fullResultsArray,minValVec)

sizeMinValVec = size(minValVec,2);

figure;
plot(fullResultsArray)
hold on

mkrSize = 10;
mkrWidth = 1.6;
% Make a handle for each reference track
h = zeros(3,1);
for i = 1:sizeMinValVec
    if minValVec(1,i) == 1
        h(1) = plot(minValVec(2,i), minValVec(3,i), 'r+','MarkerSize',mkrSize, 'LineWidth', mkrWidth);
    elseif minValVec(1,i) == 2
        h(2) = plot(minValVec(2,i), minValVec(3,i), 'go','MarkerSize',mkrSize, 'LineWidth', mkrWidth);
    elseif minValVec(1,i) == 3
        h(3) = plot(minValVec(2,i), minValVec(3,i), 'm*','MarkerSize',mkrSize, 'LineWidth', mkrWidth);
    end
end
hold off

% Format the plot
box on
legend(h,'Mvt1', 'Mvt2', 'Mvt3')

xlabel('Frame')
ylabel('(Dis) Similarity')
title('Best Matches for QueryTrack')
hold off