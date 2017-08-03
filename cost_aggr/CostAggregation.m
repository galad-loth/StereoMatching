function cost_aggr=CostAggregation(cost,  img1, img2, params)
aggr_params=params.aggr_params;
switch lower(aggr_params.type)
    case 'fw'
        cost_aggr=CostAggrFW(cost, aggr_params);
    case 'sftw'
        cost_aggr=CostAggrShiftWin(cost, aggr_params);
    case 'segw'
        cost_aggr=CostAggrSegWin(cost, aggr_params);
    case 'bilat'
        cost_aggr=CostAggrBilateral(cost, img1, img2, params);
end