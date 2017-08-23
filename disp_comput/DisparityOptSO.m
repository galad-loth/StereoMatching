function   d=DisparityOptSO(cost, params)
glbopt_params=params.glbopt_params;
cost_params=params.cost_params;

aggr_cost=CostAggrScanline(cost,glbopt_params);

[mincost, minidx]=min(aggr_cost,[],3);
if cost_params.direction==1
    d=minidx-1;   
elseif cost_params.direction==0
    d=minidx-1- cost_params.max_disp;
else
    d=cost_params.max_disp-minidx+1;
end
