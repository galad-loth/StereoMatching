function cost=MatchCostHMI(img1, img2, params)
num_scale=params.num_scale;
n_resize=2^num_scale;

img1_rs=imresize(img1,1/n_resize, 'nearest');
img2_rs=imresize(img2,1/n_resize, 'nearest');

params_local.max_disp=ceil(params.max_disp/n_resize);
params_local.direction=params.direction;
d=zeros(size(img1_rs));

for iter=1:num_scale
    p=JointPdfEstimation(img1_rs, img2_rs, params.direction*d, 256);
    cost=MICost(img1_rs, img2_rs, p, params_local);
    d=GetDisparity(cost, params_local);
    d=round(2*imresize(d, 2, 'nearest'));
    n_resize=2^(num_scale-iter);
    params_local.max_disp=ceil(params.max_disp/n_resize);
    img1_rs=imresize(img1,1/n_resize, 'nearest');
    img2_rs=imresize(img2,1/n_resize, 'nearest');
%     figure(1001);subplot(2,2,1);imagesc(p)
%     subplot(2,2,2);imagesc(d)
%     subplot(2,2,3);imagesc(img1_rs)
%     subplot(2,2,4);imagesc(img2_rs)
%     pause()
end

p=JointPdfEstimation(img1_rs, img2_rs, params.direction*d, 256);
cost=MICost(img1, img2, p, params);


function p=JointPdfEstimation(img1, img2, d, num_graylevel)
% Compute the grayscale joint distribution pdf of two images with respect
% to a given disparity map.
if numel(size(img1))>2 || numel(size(img2))>2
    error('Only grayscale images are supoorted...')
end
[nrow1, ncol1]=size(img1);
[nrow2, ncol2]=size(img2);
[nrowd, ncold]=size(d);
if nrow1~=nrowd || ncol1~=ncold
    error('Sizes of the first image and the disparity map is not the same')
end

if ~(isinteger(img1) || isinteger(img2))
    img1=round(min(img1, num_graylevel-1));
    img2=round(min(img2, num_graylevel-1));
end
p=zeros(num_graylevel, num_graylevel);

[cc1, rr1]=meshgrid(1:ncol1, 1:nrow1);
ccd=cc1+d;% shifted x-coordinates
valid_mask=ccd>0 & ccd<ncol2;

idx_valid1=rr1(valid_mask)+(cc1(valid_mask)-1)*nrow1;
idx_valid2=rr1(valid_mask)+(ccd(valid_mask)-1)*nrow1;

if (~isempty(idx_valid1))    
    valid_grayscale1=img1(idx_valid1);
    valid_grayscale2=img2(idx_valid2);
    for k=1:length(valid_grayscale1)
        p(valid_grayscale1(k)+1, valid_grayscale2(k)+1)=p(valid_grayscale1(k)+1, valid_grayscale2(k)+1)+1;
    end
    p=p/length(valid_grayscale1);
end









