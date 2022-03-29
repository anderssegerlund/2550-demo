function pheromoneLevel = UpdatePheromoneLevels(pheromoneLevel,deltaPheromoneLevel,rho)
    pheromoneLevel = (1-rho)*pheromoneLevel + deltaPheromoneLevel;
    
    for i=1:length(pheromoneLevel)
        for j=1:length(pheromoneLevel)
            if pheromoneLevel(i,j) < 10^-15
               pheromoneLevel(i,j) = 10^-15;
            end
        end
    end
end