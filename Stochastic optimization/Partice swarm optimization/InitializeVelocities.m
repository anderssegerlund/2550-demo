function velocities =  InitializeVelocities(alpha, deltaT,xMax,xMin,numberOfParticles)
    velocities = zeros(numberOfParticles,2);
    
    for i=1:numberOfParticles
        for j =1:2
            r = rand;
            velocities(i,j) = (alpha/deltaT) * (-(xMax -xMin)/2 +r*(xMax-xMin));
        
        end
    end

end