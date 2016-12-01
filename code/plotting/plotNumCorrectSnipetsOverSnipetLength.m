% ======================================================================
% This code written by R. Michael Winters
% Date created: December 1, 2016
%
%> @brief : Plot the proportion of correct results by snipet length
%> called by :: returnNumCorrectSnipetsOverSnipetLength
%>
%> @param segmentsWithSnipetResults : a struct of preprocessed segments
%    that have been filtered.
%>
%> @retval resultsForUniqueSnipetLengths: a 3xN array of snipet lengths,
%number correct, and total number of snipets
% ======================================================================


function plotNumCorrectSnipetsOverSnipetLength(resultsForUniqueSnipetLengths)

snipetLengths = resultsForUniqueSnipetLengths(1,:);
numberCorrect = resultsForUniqueSnipetLengths(2,:);
numberIncorrect = resultsForUniqueSnipetLengths(3,:) - numberCorrect;


% Plot the distribution
subplot(2,1,1)
bar(snipetLengths',[numberCorrect; numberIncorrect]', 'stacked')
ylabel('Total Number of Occurrences')
xlabel('Snipet Length (Number of Windows)')
xlim([0,100])
legend('Correctly Classified', 'Incorrectly Classified')

% Plot probability of being correct
probabilityOfBeingCorrect = numberCorrect ./ (numberCorrect + numberIncorrect);
subplot(2,1,2)
plot(snipetLengths,probabilityOfBeingCorrect, 'LineWidth', 2)
ylabel('Probability of Being Correct')
xlabel('Snipet Length (Number of Windows)')
xlim([0,100])
legend('Probability')

set(findall(gcf,'-property','FontSize'),'FontSize',18)

suptitle('Correctly Classified Snipets over Snipet Lengths')
