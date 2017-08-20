function   d=DisparityOptSO(cost, params)
glbopt_params=params.glbopt_params;
cost_params=params.cost_params;
[nrow, ncol, nchl]=size(cost);

if strcmp(glbopt_params.punish_type, 'const')
    punish_cost=glbopt_params.rau*ones(nchl, 1);
else%linear
    punish_cost=glbopt_params.rau*(0:nchl-1)';
end
punish_cost(1)=0;

cum_cost=cost;
for m=1:nrow
    disp(['Scanline Optimization. Line ', num2str(m)])
    for n=2:ncol
        temp=squeeze(cum_cost(m, n-1, :));
        for c=1:nchl
            cost_temp=temp+punish_cost(1+abs(c-(1:nchl)));
            cum_cost(m,n,c)=cost(m,n,c)+min(cost_temp);
        end
    end
end

[mincost, minidx]=min(cum_cost,[],3);
if cost_params.direction==1
    d=minidx-1;   
elseif cost_params.direction==0
    d=minidx-1- cost_params.max_disp;
else
    d=cost_params.max_disp-minidx+1;
end
