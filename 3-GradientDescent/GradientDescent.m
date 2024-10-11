clc;
clear;
close all;

% Load the data
data = load('Data.mat');
X = data.data(:, 1); % First column as feature
y = data.data(:, 2); % Second column as target
m = length(y); % Number of training examples

% Add a column of ones to X for the intercept term
X = [ones(m, 1), X];

% Initialize parameters
theta = zeros(2, 1); % Initial theta values (intercept and slope)
alpha = 0.01; % Learning rate
num_iters = 1000; % Number of iterations
cost_history = zeros(num_iters, 1); % To store cost function values

% Gradient Descent Algorithm
for iter = 1:num_iters
    % Calculate predictions
    predictions = X * theta;

    % Compute errors
    errors = predictions - y;

    % Update parameters
    theta = theta - (alpha / m) * (X' * errors);

    % Calculate cost for the current iteration
    cost_history(iter) = (1 / (2 * m)) * sum(errors .^ 2);
end

% Display results
fprintf('Theta found by gradient descent: \n');
disp(theta);

% Plot the cost history
figure;
plot(1:num_iters, cost_history, 'b-');
xlabel('Iterations');
ylabel('Cost');
title('Cost Function History');

% Visualize the fitted line
figure;
plot(X(:, 2), y, 'bo'); % Original data
hold on;
plot(X(:, 2), X * theta, 'r-'); % Fitted line
xlabel('X');
ylabel('Y');
title('Linear Regression Fit');
grid on;
hold off;

% Save plots
saveas(gcf, 'Cost_Function_History.png');
saveas(gcf, 'Linear_Regression_Fit.png');
