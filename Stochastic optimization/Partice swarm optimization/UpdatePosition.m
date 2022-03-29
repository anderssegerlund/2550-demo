function positions = UpdatePosition(positions,velocity,deltaT)
    [particles, variables] = size(positions);

    for i=1:particles
        for j=1:variables
            positions(i,j) = positions(i,j) + velocity(i,j)*deltaT; % Should multiply with deltaT
        end
    end
    
end