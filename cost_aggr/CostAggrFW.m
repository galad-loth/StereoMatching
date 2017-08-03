function cost_aggr=CostAggrFW(cost, params)
switch params.filter_type
    case 'mean'
       fsize=params.filter_size;
       f=ones(fsize, fsize)/fsize/fsize;
    case 'gaussian'
       f=fspecial('gaussian', params.filter_size, params.filter_sigma);
end

cost_aggr=zeros(size(cost));
for i=1:size(cost, 3)
    cost_aggr(:,:,i)=conv2(cost(:,:,i),f, 'same');
end