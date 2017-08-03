function params=SetParameters(img1, img2, cost_type, aggr_type, glpopt_type)
% Set all paramaters for match cost computation, cost aggrregation and
% global optimization
params.cost_params=SetCostParameters(cost_type);
if ~isempty(aggr_type)
    params.aggr_params=SetAggrParameters(img1, img2, aggr_type);
end
if ~isempty(glpopt_type)
    params.glbopt_params=SetGlboptParameters(glpopt_type);
end

function cost_params=SetCostParameters(cost_type)
% set parameters for cost computation
cost_params.max_disp=16;% maximum disparity, for ALL cost
cost_params.direction=-1;% direction, left/right/both, for ALL cost
switch lower(cost_type) % different cost type
    case 'ad' % absolute difference
       cost_params.type='ad';
    case 'sd' % sum of diffference
        cost_params.type='sd';
    case 'tad' % truncted abosolute difference
        cost_params.type='tad';
        cost_params.cost_thr=50;
    case 'sad'% truncted sum of difference
        cost_params.type='sad';
        cost_params.cost_thr=80;        
    case 'ncc'% normaolized cross-correlation
        cost_params.type='ncc';
        cost_params.ncc_winsize=9;% for NCC cost
    case 'hmi' % hierachical mutual information
        cost_params.type='hmi';
        cost_params.num_scale=3;% for HMI cost   
    otherwise
        error('Unknown cost type');
end

function aggr_params=SetAggrParameters(img1, img2, aggr_type)
% set parameters for cost aggregation
switch lower(aggr_type)
    case 'fw' % fixed window
        aggr_params.type='fw';
        aggr_params.filter_type='gaussian'; % or 'mean'
        aggr_params.filter_size=7;
        aggr_params.filter_sigma=1.5;
    case 'sftw' % shiftable window
        aggr_params.type='sftw';
        aggr_params.filter_type='gaussian'; % or 'mean'
        aggr_params.filter_size=7;
        aggr_params.filter_sigma=1.5;
        aggr_params.minfilter_size=5;
    case 'segw' % segmentation based
        aggr_params.type='segw';
        aggr_params.win_halfsize=6;
        aggr_params.lambda=0.2;
        [sp_label, sp_num]= mexSLIC(img1,2000,5,5);
        aggr_params.seg_label=sp_label;
%         img_sp_edge=GetLabelEdge(uint8(img1),sp_label);
%         figure(1001);imagesc(img_sp_edge);
    case 'bilat' %bilateral filtering
       aggr_params.type='bilat';
       aggr_params.win_halfsize=6;
       aggr_params.sigma_spatial=3;
       aggr_params.sigma_color=20;
    otherwise
        error('Unknown cost aggregation Mathod');
end

function glbopt_params=SetGlboptParameters(glpopt_type)
% set parameters for disparity optimization
switch lower(glpopt_type)
    case 'gc' % graph cut
        glbopt_params.type='gc';
        glbopt_params.alpha=100;
        glbopt_params.beta=5000;
        glbopt_params.sigma=20;
    case 'sgm' % semi-gobal matching
        glbopt_params.type='sgm';
    otherwise
        error('Unknown optimization type');
end

        