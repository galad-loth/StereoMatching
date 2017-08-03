clear; close all; clc
img1=imread('data\tsukuba\scene1.row3.col3.ppm');
img2=imread('data\tsukuba\scene1.row3.col4.ppm');
gt_disp=imread('scene1.truedisp.pgm');
% img1=rgb2gray(img1);
% img2=rgb2gray(img2);

% show images
subplot_idx=1;
figure(1);set(gcf,'position',[200 200 1200 600])
subplot(2,3,subplot_idx);imagesc(img2);colormap(gray)
title('Left image');
subplot_idx=subplot_idx+1;
subplot(2,3,subplot_idx);imagesc(img1);colormap(gray)
title('Right image');
subplot_idx=subplot_idx+1;
subplot(2,3,subplot_idx);imagesc(gt_disp);colormap(gray)
title('Disparity Groud-truth');
subplot_idx=subplot_idx+1;

img1=double(img1);
img2=double(img2);
% img1=ImgFiltering(img1, 'log', 5, 1);
% img2=ImgFiltering(img2, 'log', 5, 1);

% set parameters
cost_type='ad';
aggr_type='fw';%
glpopt_type='gc';
params=SetParameters(img1, img2, cost_type, aggr_type, glpopt_type);

cost=MatchCost(img1, img2, params);
d=GetDisparityWTA(cost, params.cost_params);
figure(1); subplot(2,3,subplot_idx);imagesc(d);colormap(gray)
title('Disparity map with pixel-based cost');
subplot_idx=subplot_idx+1;

if ~isempty(aggr_type)
    cost_ag=CostAggregation(cost, img1, img2, params);
    d=GetDisparityWTA(cost_ag, params.cost_params);
    figure(1); subplot(2,3,subplot_idx);imagesc(d);colormap(gray)
    title('Disparity map with aggrreted cost');
    subplot_idx=subplot_idx+1;
end

if ~isempty(glpopt_type)
    d=DisparityOpt(cost, img1, img2, params);    
    figure(1); subplot(2,3,subplot_idx);imagesc(d);colormap(gray)
    title('Disparity map with global optimization');
    subplot_idx=subplot_idx+1;
end

