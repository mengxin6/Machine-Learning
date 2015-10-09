function [k] = ChooseK(X, restarts, maxK)
% choose a proper k based on BIC
% X - training data
% restarts - number of iterations: for each potential value of k, run
% kmeans restarts numbers of times, and record the best BIC value.
%maxK - upperbound of k
Bic=[];
for i = 1:maxK
    bic=[];
    for j=1:restarts
        [idx,C]=kmeans(X,i);
        bic=[bic;BIC(X,C,idx,i)];
    end
    Bic=[Bic;max(bic)];
end
[~,k]=max(Bic);
end

function [bic] = BIC(X, C, idx, k)
l_D=0;
featureNumber=size(C,2);
pointNumber=size(X,1);
C1=[];
for i=1:pointNumber
    C1=[C1;C(idx(i),:)];
end    
sigmaSquare=sum(sum((X-C1).^2))/(featureNumber*(pointNumber-k));
parameterNumber=k*(featureNumber+1);
for n = 1:k
    Rn=sum((idx==n));
    l_Dn=-Rn/2*log(2*pi)-Rn*featureNumber/2*log(sigmaSquare)-(Rn-k)/2+Rn*log(Rn)-Rn*log(pointNumber);
    l_D=l_D+l_Dn;
end
bic=l_D-parameterNumber/2*log(pointNumber);
end
