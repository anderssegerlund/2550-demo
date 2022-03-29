clc
clear all
format compact
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Paramters %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%

%%% Running parameters
iterations = 200;

%%% Particle initialization parameters
numberOfParticles = 40;
xMax = 5;
xMin = -5;
alpha = 1;

%%% Velocity parameters
c1 = 2;     % Cognitive compoent
c2 = 1;     % Social component
vMax =3;
deltaT = 1;
w = linspace(1.4,0.4,iterations);

%%% Define plot 
[X,Y] = meshgrid(xMin:0.1:xMax, xMin:0.1:xMax);
f = (X.^2 + Y - 11).^2 + (X + Y.^2 -7).^2;

%%% 5.1 Algorithm step 1, 1.1 & 1.2
particlePositions = InitializePositions(xMin,xMax,numberOfParticles);
particleVelocities = InitializeVelocities(alpha, deltaT,xMax,xMin,numberOfParticles);

% Initialize vector with best particle positions (xiPb)
particleBestPositions = particlePositions;

% initialize global best (xSb)
globalBest = zeros(1,2);


for iter=1:iterations

    %%%%%%%%%%%% DENNA KANSKE GÅR ATT LÄGGA I EN FUNK ISTÄLLET
    % 5.1 Algorithm: Step 3.1 (get list of best particle positions)
    for i=1:numberOfParticles
        x = particlePositions(i,1);
        y = particlePositions(i,2);
        xPb = particleBestPositions(i,1);
        yPb = particleBestPositions(i,2);

        if EvaluateFunction(x,y) < EvaluateFunction(xPb,yPb)
            particleBestPositions(i,1) = x;
            particleBestPositions(i,2) = y;
        end
    end

    % 5.1 Algorithm: Step 3.2 (best global position)
    swarmBest = ParticleBest(numberOfParticles,particleBestPositions);

    x = swarmBest(1);
    y = swarmBest(2);
    xSb = globalBest(1);
    ySb = globalBest(2);

    if EvaluateFunction(x,y) < EvaluateFunction(xSb,ySb)
        globalBest(1) = x;
        globalBest(2) = y;
    end

    % 5.1 Algorithm: Step 4.1 & 4.2: Update velocities & restrict velocities
    
    inertiaWeight = w(iter); 
    particleVelocities = UpdateVelocity(particleVelocities,particlePositions, inertiaWeight ,c1, c2, particleBestPositions, globalBest, deltaT,vMax);

    % 5.1 Algorithm: Step 4.3 Update positions
    particlePositions = UpdatePosition(particlePositions,particleVelocities,deltaT);

    % Plot 
    a = 0.01;
    contour3(X,Y,log(a+f),150)
    xlabel('x')
    ylabel('y')
    xlim([xMin xMax])
    ylim([xMin xMax])

    hold on
    plot(particleBestPositions(:,1),particleBestPositions(:,2),'o','MarkerFaceColor','r')
    hold off
    pause(0.0001)

end


% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%% Initialize positions and velocities %%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%% 5.1 Algorithm step 1, 1.1 & 1.2
% xPositions = InitializePositions(xMin,xMax,numberOfParticles);
% velocity = InitializeVelocities(alpha, deltaT,xMax,xMin,numberOfParticles);
% 
% %%% Initialize particle best and swarm best
% pb = ParticleBest(numberOfParticles,xPositions);
% %sb = ParticleBest(numberOfParticles,xPositions);
% sb = pb;  % Assign particle best to swarm best
% 
% %Initialize a xi_pb vector with x position values
% xiPb = xPositions;
% 
% % Best particle 
% bestParticle = ParticleBest(numberOfParticles,xPositions);
% xSb = bestParticle(1);
% ySb = bestParticle(2);
% 
% for iter=1:iterations
%     %deltaT = iter;
%     % 5.1 Algorithm: Step 3
%     for i=1:length(xPositions)
%      
%         x = xPositions(i,1);
%         y = xPositions(i,2);
%         xPb = xiPb(i,1);
%         yPb = xiPb(i,2);
%         
%         % 5.1 Algorithm: Step 3.1
%         if EvaluateFunction(x,y) < EvaluateFunction(xPb,yPb)
%             xiPb(i,1) = x;
%             xiPb(i,2) = y;
%         end
%         
%         % 5.1 Algorithm: Step 3.2
%         if EvaluateFunction(x,y) < EvaluateFunction(xSb,ySb)
%             xSb = x;
%             ySb = y;
%         end 
%     end
%     % 5.1 Algorithm: Step 4.1 & 4.2: Update velocities & restrict velocities
%     q = rand;
%     
%     inertiaWeight = w(iter); 
%     velocity = UpdateVelocity(velocity,xPositions, inertiaWeight ,c1, c2, pb, sb, deltaT,vMax);
%     
%     % 5.1 Algorithm: Step 4.3 Update positions
%     xPositions = UpdatePosition(xPositions,velocity,deltaT);
%     
%     % Plot 
%     a = 0.01;
%     contour3(X,Y,log(a+f),150)
%     xlabel('x')
%     ylabel('y')
%     xlim([xMin xMax])
%     ylim([xMin xMax])
%     
%     hold on
%     plot(xPositions(:,1),xPositions(:,2),'o','MarkerFaceColor','r')
%     hold off
%     pause(0.01)
%     
% end
% disp([xSb,ySb])
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % for i =1:iterations
% %    
% %     % Update xi_pb
% %     for pos=1:length(positions)
% %         x = positions(pos,1);
% %         y = positions(pos,2);
% %         
% %         xBest =  pb(1);
% %         yBest =  pb(2);
% %         if  EvaluateFunction(xBest,yBest) < EvaluateFunction(x,y);
% %             positions(pos,1) = xBest;
% %             positions(pos,2) = yBest;
% %         end
% %         
% %     end
% % end
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% %%%%%%%% Gammal
% %for i=1:iterations
%     
% %     % Update global best position
% %     x = pb(1);
% %     y = pb(2);
% %     if EvaluateFunction(x,y) < EvaluateFunction(x,y)
% %         pb = sb;
% %     end
% %     
% %      %Update positions
% %     % deltaT =i;
% %     positions = UpdatePosition(positions,velocity,deltaT);
% %     velocity = UpdateVelocity(velocity,positions, c1, c2, q, pb, sb, deltaT,vMax);
% %     
% %     %positions
% %     contour3(X,Y,z,250)
% %     xlim([xMin xMax])
% %     ylim([xMin xMax])
% %     hold on
% %     plot(positions(:,1),positions(:,2),'o','MarkerFaceColor','r')
% %     hold off
% %     pause(0.1)
%     
% %end
%     
%     
%   
%     
% 
% 
% 
