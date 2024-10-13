clc;
clear all;
close all;

% Number of datasets and initialize accuracy array
num_datasets = 7;
accuracies = zeros(num_datasets, 1);

for i = 1:num_datasets
    disp(['Processing Dataset ', num2str(i)]);
    
    % Load dataset (assuming they are stored in .mat format)
    load(['dataArray_', num2str(i), '.mat']); % Load your dataset matrix 
    data = dataArray;  % Assume combinedData is a matrix 

    % Separate features and labels
    X = data(:, 1:end-1); % Features (all columns except last)
    y = data(:, end); % Labels (last column)

    % Split the dataset into training and testing sets (80-20 split)
    cv = cvpartition(size(X, 1), 'HoldOut', 0.2);
    idx = cv.test;
    X_train = X(~idx, :);
    y_train = y(~idx);
    X_test = X(idx, :);
    y_test = y(idx);
    
    % Adjust class weights for balancing (inverse class frequencies)
    class_weights = [1 / sum(y_train == 0), 1 / sum(y_train == 1)];
    
    % Set the number of neighbors
    k = 5; % Adjust this as needed

    % Initialize predictions
    predictions = zeros(size(X_test, 1), 1); 

    % Perform predictions using WKNN
    for j = 1:size(X_test, 1)
        % Calculate distances between the test point and all training samples
        distances = sqrt(sum((X_train - X_test(j, :)).^2, 2));
        
        % Sort distances and get indices of the k nearest neighbors
        [~, sorted_indices] = sort(distances, 'ascend'); % Ascending order
        k_indices = sorted_indices(1:k); % Get the indices of the k smallest distances
        
        % Extract labels of the k nearest neighbors
        k_nearest_labels = y_train(k_indices);
        
        % Calculate weights (inverse distance)
        weights = 1 ./ (distances(k_indices) + 1e-10); % Avoid division by zero
        
        % Adjust weights by class frequency
        adjusted_weights = weights .* class_weights(k_nearest_labels + 1); % +1 for class indexing
        
        % Weighted voting to determine the class of the test instance
        weighted_sum = sum(adjusted_weights .* k_nearest_labels);
        total_weight = sum(adjusted_weights);
        
        % Predict class based on weighted sum
        if weighted_sum >= total_weight / 2
            predictions(j) = 1; % Predict as 'positive' (1)
        else
            predictions(j) = 0; % Predict as 'negative' (0)
        end
    end
    
    % Evaluate accuracy
    accuracies(i) = sum(predictions == y_test) / length(y_test);
    fprintf('Dataset %d Accuracy: %.2f%%\n', i, accuracies(i) * 100);
end

% Display overall results
disp('Accuracies for all datasets:');
disp(accuracies);

% Plotting the accuracies
figure;
bar(accuracies * 100); % Convert to percentage for plotting
title('WKNN Classification Accuracies for Datasets');
xlabel('Datasets');
ylabel('Accuracy (%)');
xticks(1:num_datasets);
xticklabels({'Dataset 1', 'Dataset 2', 'Dataset 3', 'Dataset 4', 'Dataset 5', 'Dataset 6', 'Dataset 7'});
ylim([0 110]); % Set y-axis limits from 0 to 110%
grid on;

% Annotate bars with accuracy values
for k = 1:num_datasets
    text(k, accuracies(k) * 100 + 2, sprintf('%.2f%%', accuracies(k) * 100), ...
        'HorizontalAlignment', 'center', 'FontSize', 10);
end
