function [k] = ChooseK(X, restarts, maxK)
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
