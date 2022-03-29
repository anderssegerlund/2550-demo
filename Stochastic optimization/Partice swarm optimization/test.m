clc
%clf
[x,y] = meshgrid(-5:0.1:5, -5:01:5);
z = (x.^2 + y + 11).^2 + (x + y.^2 -7).^2;

contour3(x,y,z,250)
hold on
x1 = 0;
y1 = 0;
plot(x1,y1,'o','MarkerFaceColor','r')


%% 
clc
[x,y] = meshgrid(-3:0.1:3, -3:01:3);
z = x.^2 -y.^2;
contour(x,y,z)