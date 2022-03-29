function velocity = UpdateVelocity(velocity,positions, w,c1, c2, pb, sb, deltaT,vMax)
    I = length(velocity);
    for i=1:I
        q = rand;
        velocity(i,1) = w*velocity(i,1) + (c1 * q) * (pb(i,1)-positions(i,1))/deltaT + c2*rand*(sb(1)-positions(i,1))/deltaT;
        velocity(i,2) = w*velocity(i,2) + (c1 * q) * (pb(i,2)-positions(i,2))/deltaT + c2*rand*(sb(2)-positions(i,2))/deltaT;
        
        % Restict velocity
        if velocity(i,1) < -vMax
            velocity(i,1) = -vMax;
        end
        
        if velocity(i,1) > vMax
            velocity(i,1) = vMax;
        end
        
        if velocity(i,2) < -vMax
            velocity(i,2) = -vMax;
        end
        
        if velocity(i,2) > vMax
            velocity(i,2) = vMax;
        end
        
    end
end