function d = cosineDistance(point1, point2)
    % cosineDistance - Calculates the Cosine distance between two points
    d = 1 - (dot(point1, point2) / (norm(point1) * norm(point2)));
end
