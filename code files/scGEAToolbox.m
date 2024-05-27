% Load the data from a text file
data = readtable('/Users/nyu/Downloads/endo.csv');
% Assuming the first column is gene names and the rest are numeric data
genes = data.genes; % Save gene names
numericData = table2array(data(:, 2:end));
% Calculate Pearson residuals for each cell
% Pearson residual calculation: (Observed - Expected) / sqrt(Expected)
% Adding a small constant to the expected to avoid division by zero
smallConstant = 1e-6;
expectedCounts = mean(numericData, 2); 
pearsonResiduals = (numericData - expectedCounts) ./ sqrt(expectedCounts + smallConstant);
disp('Pearson Residuals calculated:');
disp(pearsonResiduals(1:5, :));  % Display the first 5 rows of Pearson residuals

% Create a new table including gene names and Pearson residuals
resultsTable = [table(genes), array2table(pearsonResiduals)];
resultsTable.Properties.VariableNames = ['genes', arrayfun(@(x) ['X', num2str(x)], 1:size(pearsonResiduals, 2), 'UniformOutput', false)];

% Save the Pearson residuals as a .txt file, including headers
writetable(resultsTable, '/Users/nyu/Downloads/residuals.csv');
disp('Pearson residuals saved to file.');