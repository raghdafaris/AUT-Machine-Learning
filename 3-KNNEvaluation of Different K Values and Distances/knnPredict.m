function Y_pred = knnPredict(X_train, Y_train, X_test, k)
    % knnPredict - Predicts the labels for the test set using KNN
    %
    % Inputs:
    %   X_train - Training data features (n x m)
    %   Y_train - Training data labels (n x 1)
    %   X_test  - Testing data features (t x m)
    %   k       - Number of nearest neighbors to consider
    %
    % Outputs:
    %   Y_pred - Predicted labels for the test data (t x 1)

    numTest = size(X_test, 1);
    Y_pred = zeros(numTest, 1);

    for i = 1:numTest
        % Compute the Euclidean distance between the test sample and all training samples
        distances = sqrt(sum((X_train - X_test(i, :)).^2, 2));
        
        % Get the indices of the k smallest distances
        [~, sortedIdx] = sort(distances);
        kNearestIdx = sortedIdx(1:k);

        % Retrieve the labels of the k nearest neighbors
        kNearestLabels = Y_train(kNearestIdx);

        % Predict the label by taking the mode (most frequent label)
        Y_pred(i) = mode(kNearestLabels);
    end
end
