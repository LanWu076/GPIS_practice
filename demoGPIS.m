clear all;
% close all;
clc;
addpath(genpath('gpml-matlab-v4.2-2018-06-11'));

% prepare dataset
downSample = 25;
noise = 0; % 0.01 0.02 tested
[ptTrain, normalTrain, limTest] = prepareData(noise, downSample); 

% get query points ready
[xg, yg, zg ] = meshgrid( limTest(1,1):0.07:limTest(1,2), ...
    limTest(2,1):0.07:limTest(2,2), limTest(3,1):0.07:limTest(3,2) );
ptTest = single([xg(:), yg(:), zg(:)]);

% GPIS
[mu,var] = functionGP(ptTrain,ptTest,normalTrain);
val = reshape(mu,size(xg));

% marching cube
[f,v] = isosurface(xg,yg,zg,val,0); %'noshare'
fprintf('generated vertices and faces!\n');

% remove vertices far away
D = pdist2(ptTrain, v,  'euclidean', 'Smallest', 1)';
verticesToRemove = find(D > 0.3)'; 
newVertices = v;
newVertices(verticesToRemove,:) = [];
[~, newVertexIndex] = ismember(v, newVertices, 'rows');
newFaces = f(all([f(:,1) ~= verticesToRemove, ...
    f(:,2) ~= verticesToRemove, ...
    f(:,3) ~= verticesToRemove], 2),:);
newFaces = newVertexIndex(newFaces);
v = newVertices;
f = newFaces;

% show the surface
figure;
trisurf(f, v(:,1), v(:,2), v(:,3), 'EdgeColor', 'none');
axis equal;
view(90,5);
shading interp;
camlight; lighting phong;