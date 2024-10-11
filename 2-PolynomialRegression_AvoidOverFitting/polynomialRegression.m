clc
clear all 
close all

% Load the data
myVar = load('Data.mat');
data = myVar.data;
x = data(1,:)'; % Transpose to make it a column vector
y = data(2,:)'; % Transpose to make it a column vector

% Define lambda values
lambda = [0, 10, 100];

% Initialize cell arrays to hold theta values for each degree and lambda
theta_poly2 = cell(1, 3);
theta_poly3 = cell(1, 3);
theta_poly7 = cell(1, 3);

% Prepare the design matrices for polynomial features
X_poly2 = [ones(size(x)), x, x.^2];          % Degree 2
X_poly3 = [ones(size(x)), x, x.^2, x.^3];   % Degree 3
X_poly7 = [ones(size(x)), x, x.^2, x.^3, x.^4, x.^5, x.^6, x.^7]; % Degree 7

% Calculate theta for each degree and lambda
for i = 1:length(lambda)
    % Normal equation for degree 2
    theta_poly2{i} = (X_poly2' * X_poly2 + lambda(i) * eye(3)) \ (X_poly2' * y);
    
    % Normal equation for degree 3
    theta_poly3{i} = (X_poly3' * X_poly3 + lambda(i) * eye(4)) \ (X_poly3' * y);
    
    % Normal equation for degree 7
    theta_poly7{i} = (X_poly7' * X_poly7 + lambda(i) * eye(8)) \ (X_poly7' * y);
end

% Generate predictions
x_pred = linspace(min(x), max(x), 100)'; % x values for prediction

% Degree 2 Predictions
y_pred_poly2 = cellfun(@(theta) [ones(size(x_pred)), x_pred, x_pred.^2] * theta, theta_poly2, 'UniformOutput', false);

% Degree 3 Predictions
y_pred_poly3 = cellfun(@(theta) [ones(size(x_pred)), x_pred, x_pred.^2, x_pred.^3] * theta, theta_poly3, 'UniformOutput', false);

% Degree 7 Predictions
y_pred_poly7 = cellfun(@(theta) [ones(size(x_pred)), x_pred, x_pred.^2, x_pred.^3, x_pred.^4, x_pred.^5, x_pred.^6, x_pred.^7] * theta, theta_poly7, 'UniformOutput', false);

% Create plots for Degree 2
for i = 1:3
    figure;
    hold on;
    plot(x, y, 'bo'); % Original data
    plot(x_pred, y_pred_poly2{i}, 'r-');
    xlabel('X');
    ylabel('Y');
    title([' Degree 2, Lambda=' num2str(lambda(i))]);
    grid on;

    % Save the plot for Degree 2 fits
    saveas(gcf, ['Degree2_Lambda' num2str(lambda(i)) '.png']);
    hold off;
end

% Create plots for Degree 3
for i = 1:3
    figure;
    hold on;
    plot(x, y, 'bo'); % Original data
    plot(x_pred, y_pred_poly3{i}, 'r-');
    xlabel('X');
    ylabel('Y');
    title(['Degree 3, Lambda=' num2str(lambda(i))]);
    grid on;

    % Save the plot for Degree 3 fits
    saveas(gcf, ['Degree3_Lambda' num2str(lambda(i)) '.png']);
    hold off;
end

% Create plots for Degree 7
for i = 1:3
    figure;
    hold on;
    plot(x, y, 'bo'); % Original data
    plot(x_pred, y_pred_poly7{i}, 'r-');
    xlabel('X');
    ylabel('Y');
    title(['Degree 7, Lambda=' num2str(lambda(i))]);
    grid on;

    % Save the plot for Degree 7 fits
    saveas(gcf, ['Degree7_Lambda' num2str(lambda(i)) '.png']);
    hold off;
end
