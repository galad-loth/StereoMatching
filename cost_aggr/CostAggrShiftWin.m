function cost_aggr=CostAggrShiftWin(cost, params)
switch params.filter_type
    case 'mean'
       fsize=params.filter_size;
       f=ones(fsize, fsize)/fsize/fsize;
    case 'gaussian'
       f=fspecial('gaussian', params.filter_size, params.filter_sigma);
end

cost_aggr=zeros(size(cost));
for i=1:size(cost, 3)
    temp=conv2(cost(:,:,i),f, 'same');
    cost_aggr(:,:,i)=ordfilt2(temp, 1, true(params.minfilter_size));
end