function pathLength = GetPathLength(path,cityLocation);  
pathLength = 0;

% Set node_j to the first node in the path
cityI = cityLocation(path(1),:);

for i=2:length(path)
    % Se node_j to second node in the path
    cityJ = cityLocation(path(i),:);
    
    % Calculate Euclidean Distance between nodes
    euclideanDistance = sqrt(sum((cityI -cityJ).^2));
    
    % Add Euclidean Distance to pathlength
    pathLength = pathLength + euclideanDistance;
    
    % Increment node
    cityI = cityJ;

end

% Add distance for returning to first node
cityI = cityLocation(path(end),:);
cityJ = cityLocation(path(1),:);

% Calculate Euclidean Distance between nodes
euclideanDistance = sqrt(sum((cityI -cityJ).^2));

% Add Euclidean Distance to pathlength
pathLength = pathLength + euclideanDistance;

end