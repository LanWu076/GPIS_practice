function X = normalisePoints(X)
    minX = min(X); 
    lenX = max(X) - minX;
    X = (X - minX)./lenX;
end
