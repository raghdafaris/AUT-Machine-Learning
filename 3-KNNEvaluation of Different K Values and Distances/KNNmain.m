% main.m - Entry point for running the KNN implementation and distance metric analysis
clc
clear all
close all
% Load and prepare data
data = load('seeds_dataset.txt'); 
X = data(:, 1:7); % Features
Y = data(:, 8); % Labels

% Normalize features
X = (X - min(X)) ./ (max(X) - min(X));

% Set up cross-validation parameters
numFolds = 10;
k_values = [1, 3, 5, 7, 10];

% Create folds for cross-validation
folds = createFolds(X, Y, numFolds);

% Part (a): Run KNN for different K values and calculate accuracy
fprintf('Running KNN for different K values with 10-fold cross-validation...\n');
accuracy_a = zeros(length(k_values), 1);

for idx = 1:length(k_values)
    k = k_values(idx);
    correctPredictions = 0;
    totalPredictions = 0;
    
    for j = 1:numFolds
        X_train = folds{j, 1};
        Y_train = folds{j, 2};
        X_test = folds{j, 3};
        Y_test = folds{j, 4};
        
        Y_pred = knnPredict(X_train, Y_train, X_test, k);
        correctPredictions = correctPredictions + sum(Y_pred == Y_test);
        totalPredictions = totalPredictions + length(Y_test);
    end
    
    accuracy_a(idx) = correctPredictions / totalPredictions;
    fprintf('Accuracy for K=%d: %.2f%%\n', k, accuracy_a(idx) * 100);
end

% Plot the accuracy for each K value
figure;
plot(k_values, accuracy_a, '-o');
xlabel('K value');
ylabel('Accuracy');
title('KNN Accuracy with 10-Fold Cross-Validation');
% Save the figure
saveas(gcf, 'KNNAccuracywith10-FoldCross-Validation.png'); % Save as PNG

% Part (b): Run KNN with different distance metrics
fprintf('\nRunning KNN with different distance metrics (K=5)...\n');
distanceFuncs = {@euclideanDistance, @manhattanDistance, ...
                 @(x1, x2) minkowskiDistance(x1, x2, 4), ...
                 @(x1, x2) minkowskiDistance(x1, x2, 0.5), ...
                 @cosineDistance};
funcNames = {'Euclidean', 'Manhattan', 'Minkowski (p=4)', 'Minkowski (p=1/2)', 'Cosine'};
accuracy_b = zeros(length(distanceFuncs), 1);
k = 5; % Fixed K for this part

for idx = 1:length(distanceFuncs)
    distanceFunc = distanceFuncs{idx};
    correctPredictions = 0;
    totalPredictions = 0;
    
    for j = 1:numFolds
        X_train = folds{j, 1};
        Y_train = folds{j, 2};
        X_test = folds{j, 3};
        Y_test = folds{j, 4};
        
        Y_pred = knnPredictCustom(X_train, Y_train, X_test, k, distanceFunc);
        correctPredictions = correctPredictions + sum(Y_pred == Y_test);
        totalPredictions = totalPredictions + length(Y_test);
    end
    
    accuracy_b(idx) = correctPredictions / totalPredictions;
    fprintf('%s Distance Accuracy: %.2f%%\n', funcNames{idx}, accuracy_b(idx) * 100);
end

% Plot the accuracy for each distance metric
figure;
bar(categorical(funcNames), accuracy_b);
xlabel('Distance Metric');
ylabel('Accuracy');
title('KNN Accuracy with Different Distance Metrics (K=5)');
% Save the figure
saveas(gcf, 'KNN_Accuracy_with_Different_Distance.png'); % Save as PNG