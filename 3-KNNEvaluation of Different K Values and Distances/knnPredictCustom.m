function Y_pred = knnPredictCustom(X_train, Y_train, X_test, k, distanceFunc)
    % knnPredictCustom - Predicts labels for the test set using KNN with a custom distance function
    %
    % Inputs:
    %   X_train - Training data features (n x m)
    %   Y_train - Training data labels (n x 1)
    %   X_test  - Testing data features (t x m)
    %   k       - Number of nearest neighbors to consider
    %   distanceFunc - Function handle for distance calculation
    %
    % Outputs:
    %   Y_pred - Predicted labels for the test data (t x 1)

    numTest = size(X_test, 1);
    Y_pred = zeros(numTest, 1);

    for i = 1:numTest
        % Calculate distances using the provided distance function
        distances = arrayfun(@(j) distanceFunc(X_train(j, :), X_test(i, :)), 1:size(X_train, 1))';

        % Get the indices of the k smallest distances
        [~, sortedIdx] = sort(distances);
        kNearestIdx = sortedIdx(1:k);

        % Retrieve the labels of the k nearest neighbors
        kNearestLabels = Y_train(kNearestIdx);

        % Predict the label by taking the mode (most frequent label)
        Y_pred(i) = mode(kNearestLabels);
    end
end
