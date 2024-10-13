function folds = createFolds(X, Y, numFolds)
    % createFolds - Splits data into numFolds folds for cross-validation
    %
    % Inputs:
    %   X - Feature matrix (n x m)
    %   Y - Labels vector (n x 1)
    %   numFolds - Number of folds (e.g., 10)
    %
    % Outputs:
    %   folds - A cell array containing training and test sets for each fold.
    %           folds{i, 1} - Training data features for fold i
    %           folds{i, 2} - Training data labels for fold i
    %           folds{i, 3} - Testing data features for fold i
    %           folds{i, 4} - Testing data labels for fold i

    % Get the total number of samples
    numSamples = size(X, 1);

    % Create an index array and shuffle it
    indices = randperm(numSamples);

    % Calculate the size of each fold
    foldSize = floor(numSamples / numFolds);

    % Initialize the cell array for storing folds
    folds = cell(numFolds, 4);

    for i = 1:numFolds
        % Determine the indices for the test set of this fold
        testIdx = indices((i-1)*foldSize + 1 : min(i*foldSize, numSamples));
        
        % Remaining indices are used for training
        trainIdx = setdiff(indices, testIdx);

        % Assign training and testing sets for this fold
        folds{i, 1} = X(trainIdx, :); % Training features
        folds{i, 2} = Y(trainIdx, :); % Training labels
        folds{i, 3} = X(testIdx, :);  % Testing features
        folds{i, 4} = Y(testIdx, :);  % Testing labels
    end
end
