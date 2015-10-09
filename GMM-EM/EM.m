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

function [w] = Expectation(X, k, t, mu, sigma)
w=[];
for i=1:k
    w=[w,t(i)*mvnpdf(X,mu(i,:),sigma(:,:,i))];
end
w=w./repmat(sum(w,2),[1,k]);
end

function [sigma] = MaximizeCovariance(X, k, w, mu)
sigma=[];
for i=1:k
    Nk=sum(w(:,i));
    X_norm=X-repmat(mu(i,:),[size(X,1),1]);
    sigma(:,:,i)=(repmat(w(:,i),[1,size(X,2)]).*X_norm)'*X_norm/Nk;
end
end

function [t] = MaximizeMixtures(k, w)
t=mean(w)';
end
function [mu] = MaximizeMean(X, k, w)
mu=[];
for i=1:k
    Nk=sum(w(:,i));
    mu=[mu;sum(X.*repmat(w(:,i),[1,size(X,2)]))/Nk];
end
end

