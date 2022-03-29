function deltaPheromoneLevel = ComputeDeltaPheromoneLevels(pathCollection,pathLengthCollection)  
    [nPaths, nCities] = size(pathCollection);
    deltaPheromoneLevel = zeros(nCities);    

    for path=1:nPaths
        cityi = pathCollection(path,1) ;
        for n=2:nCities
            cityj = pathCollection(path,n);
            deltaPheromoneLevel(cityi,cityj) = deltaPheromoneLevel(cityi,cityj) + 1/pathLengthCollection(path);
            cityi = cityj;
        end
    end
end
