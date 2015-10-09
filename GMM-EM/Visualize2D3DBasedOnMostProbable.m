function Visualize2D3DBasedOnMostProbable(X,w)
dim=size(X,2);
[~,idx]=max(w,[],2);
if dim==2
    scatter(X(:,1),X(:,2),[],idx);
    hold on;
elseif dim==3
    scatter3(X(:,:,1),X(:,:,2),X(:,:,3),[],idx);
    hold on;
else
    fprintf('input data must be in 2D/3D space');
end
end
