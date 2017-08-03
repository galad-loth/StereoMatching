function d=DisparityOpt(cost, img1, img2, params)
glbopt_params=params.glbopt_params;
switch lower(glbopt_params.type)
    case 'gc'
        d=DisparityOptGC(cost, img1, img2, params);
    case 'sgm'
        d=DisparityOptSGM(cost, img1, img2, params);
end