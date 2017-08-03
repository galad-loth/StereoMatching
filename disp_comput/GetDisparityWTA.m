function d=GetDisparityWTA(cost, params)
[mincost, minidx]=min(cost,[],3);
if params.direction==1
    d=minidx-1;   
elseif params.direction==0
    d=minidx-1- params.max_disp;
else
    d=params.max_disp-minidx+1;
end