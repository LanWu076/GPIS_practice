
function [ptTrainDense, normals, dataRange] = prepareData(noise, downSamples)
    % Pre-processing code to restructure dataset
    
    % load Stanford bunny
    fprintf('loading dataset...\n');
    load('bunny.mat');
    ptsTot = obj.v; 
    normalTot = obj.vn;
    
    ptsTot = [ptsTot(:,3),ptsTot(:,1),ptsTot(:,2)];
    normalTot = [normalTot(:,3),normalTot(:,1),normalTot(:,2)];
    
    % normalise points and normals
    % ptsTot = normalisePoints(ptsTot);
    normalTot = normalTot ./ sqrt(sum(normalTot.^2, 2));

    % add some noise
    ptsTot = ptsTot + noise*randn(size(ptsTot,1), 3);
    normalTot = normalTot + 0*randn(size(ptsTot,1), 3);

    % downsample the total points and normals, remain 1/downSamples percent
    ptTrainDense = ptsTot(1:downSamples:end,:);
    normals = normalTot(1:downSamples:end,:);   

    % decide the range for testing points
    dataRange = [min(ptTrainDense)'-0.1,max(ptTrainDense)'+0.1];
    
    % plot training points and normals
    if 0
        figure;
        quiver3(ptTrainDense(:,1), ptTrainDense(:,2), ptTrainDense(:,3), normals(:,1), normals(:,2), normals(:,3)); hold on
        axis equal;
        view(90,5);
    end
    fprintf('dataset ready!\n');
end