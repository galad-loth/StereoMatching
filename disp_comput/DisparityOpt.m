function d=DisparityOpt(cost, img1, img2, params)
glbopt_params=params.glbopt_params;
switch lower(glbopt_params.type)
    case 'gc'
        d=DisparityOptGC(cost, img1, img2, params);
    case 'dp'
        d=DisparityOptDP(cost, params);
    case 'so'
        d=DisparityOptSO(cost, params);        
    case 'sgm'
        d=DisparityOptSGM(cost, img1, img2, params);
end