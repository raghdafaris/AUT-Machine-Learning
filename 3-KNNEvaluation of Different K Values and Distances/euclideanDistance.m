function d = euclideanDistance(point1, point2)
    % euclideanDistance - Calculates the Euclidean distance between two points
    d = sqrt(sum((point1 - point2).^2));
end
