clc;
clear all;
close all;

% Number of datasets
num_datasets = 7;

% Initialize cell array to store the converted data arrays
dataArrays = cell(num_datasets, 1);

for i = 1:num_datasets
    disp(['Processing Dataset ', num2str(i)]);
    
    % Load dataset (assuming they are stored in .mat format)
    load(['Data_', num2str(i), '.mat']); % Load your dataset matrix
    data = combinedData;  % Assume combinedData is a table

    % Check the last column type and convert categorical to numeric
    if iscategorical(data{:, end})
        % Create a numeric array to store the converted labels
        numericLabels = zeros(height(data), 1); 

        % Set 1 for 'positive' and 0 for 'negative'
        numericLabels(data{:, end} == 'positive') = 1; 
        numericLabels(data{:, end} == 'negative') = 0; 

        % Replace the last column with the numeric labels
        data = [data(:, 1:end-1), array2table(numericLabels, 'VariableNames', {'Labels'})]; 
    end

    % Convert the modified table to a numeric array
    dataArray = table2array(data);
    
       % Save the combined data to a .mat file with a unique name
    save(['dataArray_', num2str(i), '.mat'], 'dataArray'); 
end


