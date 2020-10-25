close all
clear all
clc

x = linspace(-2, 2, 30);
pointsx = linspace(-1.5, 1.5, 5);
y = x.^3 + 1;
pointsy = pointsx.^3 + 1;

figure;
plot(x,y); hold on;
axis on;
grid on;
plot(pointsx, pointsy,'r.','MarkerSize',20); hold on;
title('y = f(x) = x^3 + 1');
set(gca,'FontSize',15);

[X,Y] = meshgrid(-5:0.1:5,-5:0.1:5);
Z = sin(X) + cos(Y);
figure;
surf(X,Y,Z,'EdgeColor','none');
shading interp;
camlight; lighting phong;
axis equal;
title('z = f(x,y) = sin(x) + cos(y)');
set(gca,'FontSize',15);

figure;
% f0 = @(x,y,z) 1./x.^2 - 1./y.^2 + 1./z.^2;
f1 = @(x,y,z) (x.^2 + y.^2 + z.^2 + 1 - 0.5.^2).^2 - 4*(x.^2 + y.^2);
f2 = @(x,y,z) (x.^2 + y.^2 + z.^2 + 1 - 0.5.^2).^2 - 4*(x.^2 + z.^2);
f3 = @(x,y,z) (x.^2 + y.^2 + z.^2 + 1 - 0.5.^2).^2 - 4*(y.^2 + z.^2);

fimplicit3(f1,'EdgeColor','none'); hold on;
%fimplicit3(f2,'EdgeColor','none'); hold on;
%fimplicit3(f3,'EdgeColor','none'); hold on;
shading interp;
camlight; lighting phong;
axis equal;
title('0 = f(x,y,z) = (x^2 + y^2 + z^2 + 1 - 0.2^2)^2 - 4*(x^2 + y^2)');
set(gca,'FontSize',15);