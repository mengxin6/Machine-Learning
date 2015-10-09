function [t, mu, sigma w] = EM(X, k, t0, mu0, sigma0, nIter)
%X - n x f matrix of training data. Each row is a data sample. 
%k - number of gaussians in gaussian mixture model.
%t0 - k x 1 vector,initialized mixture weights(gaussian priorprobabilities)
%mu0 - k x f matrix, initialized means of gaussians
%sigma0 - fxfxk array, initialized covarience of gaussians
%nIter - number of EM iterations
t=t0;
mu=mu0;
sigma=sigma0;
for i=1:nIter
    w=Expectation(X,k,t,mu,sigma);
    t=MaximizeMixtures(k,w);
    mu=MaximizeMean(X,k,w);
    sigma=MaximizeCovariance(X,k,w,mu);
end

end
