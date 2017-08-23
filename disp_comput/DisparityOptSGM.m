function d=DisparityOptSGM(cost, params)
glbopt_params=params.glbopt_params;
cost_params=params.cost_params;
if isempty(glbopt_params.ori)
    aggr_cost=cost;
else
    aggr_cost=zeros(size(cost));
    aggr_param.punish_type=glbopt_params.punish_type;
    aggr_param.rau=glbopt_params.rau;
    aggr_param.ori=1;
    for k=1:length(glbopt_params.ori)
        aggr_param.ori=glbopt_params.ori(k);
        aggr_cost_temp=CostAggrScanline(cost,aggr_param);
        aggr_cost=aggr_cost+aggr_cost_temp;
    end
    aggr_cost=aggr_cost/length(glbopt_params.ori);
end


[mincost, minidx]=min(aggr_cost,[],3);
if cost_params.direction==1
    d=minidx-1;   
elseif cost_params.direction==0
    d=minidx-1- cost_params.max_disp;
else
    d=cost_params.max_disp-minidx+1;
end