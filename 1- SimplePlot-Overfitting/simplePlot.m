% Load the .mat file
myVar = load('Data.mat');
data = myVar.data;

% Separate x and y values from the data matrix
x = data(1, :); % First row for x values
y = data(2, :); % Second row for y values

% Plotting the data
figure;
plot(x, y, 'b*');
xlabel('X');
ylabel('Y');
title('Plot of Y as a function of X');
grid on;

% Save the plot as a PNG file
saveas(gcf, 'myPlot.png');
