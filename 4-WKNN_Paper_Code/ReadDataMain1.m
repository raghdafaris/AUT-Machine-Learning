clear all 
clc

% List of .dat files to read
fileNames = {'ecoli1.dat', 'glass0.dat', 'glass1.dat', ...
             'iris0.dat', 'pima.dat', ...
             'wisconsin.dat', 'yeast1.dat'}; 

% Initialize a cell array to store all combined data
allData = {};

for f = 1:length(fileNames)
    % Open the .dat file
    fileID = fopen(fileNames{f}, 'r');
    
    % Check if the file opened successfully
    if fileID == -1
        error('Could not open file: %s', fileNames{f});
    end
    
    % Read the entire file as a cell array of strings
    data = textscan(fileID, '%s', 'Delimiter', '\n');
    
    % Close the file
    fclose(fileID);
    
    % Preallocate arrays
    numRows = length(data{1}); % Total number of rows
    categoricalData = cell(numRows, 1); % Preallocate for categorical values

    % Create a temporary numeric matrix for this file
    tempNumericMatrix = []; % Initialize empty matrix for numeric values

    % Loop through each entry and parse the data
    for i = 1:numRows
        % Split the string by commas
        splitData = strsplit(data{1}{i}, ',');
        
        % Convert all but the last element to numbers
        numericParts = str2double(splitData(1:end-1)); % All but last element are numeric
        
        % Append to tempNumericMatrix; this will be a row
        tempNumericMatrix = [tempNumericMatrix; numericParts]; 
       
        % Store the last element (categorical) in categoricalData
        categoricalData{i} = splitData{end}; 
    end

    % Determine the number of numeric columns
    numNumericCols = size(tempNumericMatrix, 2);
    
    % Create a table from the numeric data
    numericTable = array2table(tempNumericMatrix, 'VariableNames', ...
        strcat('Feature', string(1:numNumericCols))); % Name numeric features

    % Add the categorical column as a separate variable
    categoricalTable = table(categorical(categoricalData), 'VariableNames', {'Label'});

    % Combine numeric and categorical tables
    combinedData = [numericTable, categoricalTable]; % Concatenate tables

    % Save the combined data to a .mat file with a unique name
    save(['Data_', num2str(f), '.mat'], 'combinedData'); 

    % Optionally, display the combined data
    disp(['Data for ', fileNames{f}, ':']);
    disp(combinedData); % Display the combined data
end
