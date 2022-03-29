function visibility = GetVisibility(cityLocation)
    
    totalCities = length(cityLocation);
    visibility = zeros(totalCities);
    
    for i=1:totalCities
        for j=1:totalCities  
            cityi = cityLocation(i,:);
            cityj = cityLocation(j,:);
            
            d = sqrt(sum((cityi -cityj).^2));
                
            if i==j
                visibility(i,j) = 0;
            else
                visibility(i,j) = 1/d;
            end
        end
    end
end