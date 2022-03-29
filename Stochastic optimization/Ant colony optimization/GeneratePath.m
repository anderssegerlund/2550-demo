function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
    numberOfNodes = length(pheromoneLevel);
    path = zeros(1,numberOfNodes); 
    tabuList = zeros(1,numberOfNodes);
    numberOfNodes = size(pheromoneLevel,1);
    
    startingNode = randi(numberOfNodes,1,1);
    path(1) = startingNode;
    tabuList(startingNode) = 1;
    
        for i=1:numberOfNodes-1
            probTour= ProbabilityTour2(path(i),pheromoneLevel,visibility,numberOfNodes,tabuList,alpha, beta);
            selectedNode = RouletteWheelSelection(probTour);
            path(i+1) = selectedNode;
            tabuList(selectedNode) = 1;
        end
end

% Function generating probability (e_ij | S) in algorithm 4.1
function probTour= ProbabilityTour(startingNode,pheromoneLevel,visibility,numberOfNodes,tabuList,alpha, beta)
    probTour = [];
    for j=1:numberOfNodes
        numerator = pheromoneLevel(startingNode, j)^alpha * visibility(startingNode, j)^beta;
        
        denominator = 0;
        for j2 =1:numberOfNodes
            
            if ismember(j2,tabuList)== 0 % Skip index if in tabu list
                denominator = denominator + pheromoneLevel(startingNode, j2)^alpha * visibility(startingNode, j2)^beta;
                probTour(j) = numerator/denominator;
            else
                continue
            end
        end
    end
end


function probTour= ProbabilityTour2(startingNode,pheromoneLevel,visibility,numberOfNodes,tabuList,alpha, beta)
probTour = [];
denominator = 0;
    for j2 =1:numberOfNodes
        if tabuList(j2) == 0 % Skip index if in tabu list
            denominator = denominator + pheromoneLevel(startingNode, j2)^alpha * visibility(startingNode, j2)^beta;
        else
            continue
        end
    end

    for j =1:numberOfNodes
        if tabuList(j)== 1
            probTour(j) = 0;
        else
            numerator = pheromoneLevel(startingNode, j)^alpha * visibility(startingNode, j)^beta;
            probTour(j) = numerator/ denominator;
        end 
    end
end

function selectedNode = RouletteWheelSelection(probTour)
cumulativeRelFitness = [];
cumulativeRelFitness(1) = probTour(1) / sum(probTour);

    for i=2:length(probTour)
        cumulativeRelFitness(i) = cumulativeRelFitness(i-1) +(probTour(i) / sum(probTour));
    end
    
    r = rand;
    selectedNode = find( cumulativeRelFitness > r, 1 );
end