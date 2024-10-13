function d = minkowskiDistance(point1, point2, p)
    % minkowskiDistance - Calculates the Minkowski distance between two points
    d = sum(abs(point1 - point2).^p)^(1/p);
end
