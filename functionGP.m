function [mu,var] = functionGP(ptTrainOn, ptTest, normal)
    
    % generating interior and exterior constraints
    ptTrainOut = ptTrainOn + normal*0.1;
    ptTrainOut = ptTrainOut(1:4:end,:);
    ptTrainIn = [0.6, 0.5, 0.4];  
    ptTrainGL = [ptTrainOn; ptTrainOut; ptTrainIn];  
    y = [zeros(size(ptTrainOn,1),1); -1.*ones(size(ptTrainOut,1),1); ...
        1.*ones(size(ptTrainIn,1),1)];    
    
    % plot points
    if 1
        figure;
        scatter3(ptTrainOut(:,1),ptTrainOut(:,2),ptTrainOut(:,3),'b.'); hold on; 
        scatter3(ptTrainIn(:,1),ptTrainIn(:,2),ptTrainIn(:,3),'ko'); hold on;
        scatter3(ptTrainOn(:,1),ptTrainOn(:,2),ptTrainOn(:,3),'r.');
        axis equal;
        view(90,5);
    end
    
    fprintf('start GP!\n');
    fprintf('number of (ptTrainOut, ptTrainIn, ptTrainOn, ptTrainTotal, ptTest) = (%.0f, %.0f, %.0f, %.0f, %.0f)\n\n', ...
        size(ptTrainOut,1), size(ptTrainIn,1), size(ptTrainOn,1), size(ptTrainGL,1), size(ptTest,1));
    
    meanfunc = [];
    covfunc = {'covMaterniso',3 };      % Matern covariance function 
    % covfunc = 'covSEiso';             % SE covariance function
    likfunc = @likGauss;                % Gaussian likelihood  
    
    % -----------------Global GP inference-------------------------
    hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
    hyp = minimize(hyp, @gp, -50, @infGaussLik, meanfunc, covfunc, likfunc, ptTrainGL, y);
    fprintf('optimised hyper: (cov1, cov2) = (%.10f, %.10f)\n', hyp.cov(1), hyp.cov(2));
    [mu, var] = gp(hyp, @infGaussLik, meanfunc, covfunc, likfunc, ptTrainGL, y, ptTest);  
end       