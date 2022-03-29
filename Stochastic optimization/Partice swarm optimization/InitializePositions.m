function positions = InitializePositions(xMin,xMax,numberOfParticles)
    positions = zeros(numberOfParticles,2);
   
    for i=1:numberOfParticles
        for j =1:2
            r = rand;
            positions(i,j) = xMin + r*(xMax -xMin);
        end
    end
end