function cost_aggr=CostAggrScanline(cost, params)
[nrow, ncol, nchl]=size(cost);

if strcmp(params.punish_type, 'const')
    punish_cost=params.rau*ones(nchl, 1);
else%linear
    punish_cost=params.rau*(0:nchl-1)';
end
punish_cost(1)=0;

switch (params.ori)
    case 1
        cost_aggr=AggrFunc1(cost, punish_cost);
    case 2
        cost_aggr=AggrFunc2(cost, punish_cost);
    case 3
        cost_aggr=AggrFunc3(cost, punish_cost);
    case 4
        cost_aggr=AggrFunc4(cost, punish_cost);
    case 5
        cost_aggr=AggrFunc5(cost, punish_cost);
    case 6
        cost_aggr=AggrFunc6(cost, punish_cost);
    case 7
        cost_aggr=AggrFunc7(cost, punish_cost);
    case 8
        cost_aggr=AggrFunc8(cost, punish_cost);
    otherwise
        error('Only 8 directions are supported.')
end
cost_aggr=cost_aggr(2:end-1,2:end-1,:);
  

function cost_aggr=AggrFunc1(cost, punish_cost)
[nrow, ncol, nchl]=size(cost);
cost_aggr=padarray(cost, [1 1 0], 0, 'both');
for m=2:nrow+1
    disp(['Scanline Optimization. Line ', num2str(m)])
    for n=2:ncol+1
        temp=squeeze(cost_aggr(m, n-1, :));
        temp_min=min(temp);
        for c=1:nchl
            cost_temp=temp+punish_cost(1+abs(c-(1:nchl)));
            cost_aggr(m,n,c)=cost(m-1,n-1,c)+min(cost_temp)-temp_min;
        end
    end
end

function cost_aggr=AggrFunc2(cost, punish_cost)
[nrow, ncol, nchl]=size(cost);
cost_aggr=padarray(cost, [1 1 0], 0, 'both');
for m=2:nrow+1
    disp(['Scanline Optimization. Line ', num2str(m)])
    for n=2:ncol+1
        temp=squeeze(cost_aggr(m-1, n-1, :));
        temp_min=min(temp);
        for c=1:nchl
            cost_temp=temp+punish_cost(1+abs(c-(1:nchl)));
            cost_aggr(m,n,c)=cost(m-1,n-1,c)+min(cost_temp)-temp_min;
        end
    end
end

function cost_aggr=AggrFunc3(cost, punish_cost)
[nrow, ncol, nchl]=size(cost);
cost_aggr=padarray(cost, [1 1 0], 0, 'both');
for m=2:nrow+1
    disp(['Scanline Optimization. Line ', num2str(m)])
    for n=fliplr(2:ncol+1)
        temp=squeeze(cost_aggr(m-1, n, :));
        temp_min=min(temp);
        for c=1:nchl
            cost_temp=temp+punish_cost(1+abs(c-(1:nchl)));
            cost_aggr(m,n,c)=cost(m-1,n-1,c)+min(cost_temp)-temp_min;
        end
    end
end

function cost_aggr=AggrFunc4(cost, punish_cost)
[nrow, ncol, nchl]=size(cost);
cost_aggr=padarray(cost, [1 1 0], 0, 'both');
for m=2:nrow+1
    disp(['Scanline Optimization. Line ', num2str(m)])
    for n=fliplr(2:ncol+1)
        temp=squeeze(cost_aggr(m-1, n+1, :));
        temp_min=min(temp);
        for c=1:nchl
            cost_temp=temp+punish_cost(1+abs(c-(1:nchl)));
            cost_aggr(m,n,c)=cost(m-1,n-1,c)+min(cost_temp)-temp_min;
        end
    end
end

function cost_aggr=AggrFunc5(cost, punish_cost)
[nrow, ncol, nchl]=size(cost);
cost_aggr=padarray(cost, [1 1 0], 0, 'both');
for m=fliplr(2:nrow+1)
    disp(['Scanline Optimization. Line ', num2str(m)])
    for n=fliplr(2:ncol+1)
        temp=squeeze(cost_aggr(m, n+1, :));
        temp_min=min(temp);
        for c=1:nchl
            cost_temp=temp+punish_cost(1+abs(c-(1:nchl)));
            cost_aggr(m,n,c)=cost(m-1,n-1,c)+min(cost_temp)-temp_min;
        end
    end
end

function cost_aggr=AggrFunc6(cost, punish_cost)
[nrow, ncol, nchl]=size(cost);
cost_aggr=padarray(cost, [1 1 0], 0, 'both');
for m=fliplr(2:nrow+1)
    disp(['Scanline Optimization. Line ', num2str(m)])
    for n=fliplr(2:ncol+1)
        temp=squeeze(cost_aggr(m+1, n+1, :));
        temp_min=min(temp);
        for c=1:nchl
            cost_temp=temp+punish_cost(1+abs(c-(1:nchl)));
            cost_aggr(m,n,c)=cost(m-1,n-1,c)+min(cost_temp)-temp_min;
        end
    end
end

function cost_aggr=AggrFunc7(cost, punish_cost)
[nrow, ncol, nchl]=size(cost);
cost_aggr=padarray(cost, [1 1 0], 0, 'both');
for m=fliplr(2:nrow+1)
    disp(['Scanline Optimization. Line ', num2str(m)])
    for n=2:ncol+1
        temp=squeeze(cost_aggr(m+1, n, :));
        temp_min=min(temp);
        for c=1:nchl
            cost_temp=temp+punish_cost(1+abs(c-(1:nchl)));
            cost_aggr(m,n,c)=cost(m-1,n-1,c)+min(cost_temp)-temp_min;
        end
    end
end


function cost_aggr=AggrFunc8(cost, punish_cost)
[nrow, ncol, nchl]=size(cost);
cost_aggr=padarray(cost, [1 1 0], 0, 'both');
for m=fliplr(2:nrow+1)
    disp(['Scanline Optimization. Line ', num2str(m)])
    for n=2:ncol+1
        temp=squeeze(cost_aggr(m+1, n-1, :));
        temp_min=min(temp);
        for c=1:nchl
            cost_temp=temp+punish_cost(1+abs(c-(1:nchl)));
            cost_aggr(m,n,c)=cost(m-1,n-1,c)+min(cost_temp)-temp_min;
        end
    end
end