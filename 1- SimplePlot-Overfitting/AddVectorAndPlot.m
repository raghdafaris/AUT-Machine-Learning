clc
clear all
close all 

% Load the .mat file
myVar = load('Data.mat');
data = myVar.data;

% Separate x and y values from the data matrix
x = data(1, :); % First row for x values
y = data(2, :); % Second row for y values

% Add a new dimension (a column of ones) to the x data
x_new = [x; ones(1, length(x))]; % Add a row of ones

% Plot the original data
figure;
plot(x, y, 'b*');
xlabel('X');
ylabel('Y');
title('Plot of Y as a function of X ');
grid on;

% Save the original plot
saveas(gcf, 'originalPlot.png');

% Plot the modified x data (with an extra column of ones) against y
figure;
plot3(x_new(1,:), x_new(2,:), y, 'r*'); % 3D plot: x, 1s, y
xlabel('X');
ylabel('Bias (Ones)');
zlabel('Y');
title('Adding a Dimension');
grid on;

% Save the modified plot
saveas(gcf, 'modifiedPlot_withBias.png');
