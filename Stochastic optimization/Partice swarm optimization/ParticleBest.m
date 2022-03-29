function bestParticle = ParticleBest(numberOfParticles,positions)
  functionValue = zeros(length(positions),1);



    for i=1:numberOfParticles
        x = positions(i,1);
        y = positions(i,2);

        functionValue(i) = (x.^2 + y - 11).^2 + (x + y.^2 -7).^2;
    end

    fMin = min(functionValue);
    fMinIndex = find(functionValue==fMin);
    bestParticle = positions(fMinIndex,:);
end