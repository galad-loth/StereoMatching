function cost=MatchCost(img1, img2, params)
[nrow1, ncol1, ndim1]=size(img1);
[nrow2, ncol2, ndim2]=size(img2);
if (nrow1~=nrow2 || ncol1~=ncol2 || ndim1~=ndim2)
    cost=0;
    return
end
cost_params=params.cost_params;
switch lower(cost_params.type)
    case {'ad', 'sd', 'tad', 'tsd'}
        cost=MatchCostAD(img1, img2, cost_params);
    case 'bt'
        cost=MatchCostBT(img1, img2, cost_params);
    case 'ncc'
        cost=MatchCostNCC(img1, img2, cost_params);
    case 'hmi'
        cost=MatchCostHMI(img1, img2, cost_params);
end

