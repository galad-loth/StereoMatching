function cost=MatchCostNCC(img1, img2, params)
[nrow2, ncol2, ndim2]=size(img2);
win_size=params.ncc_winsize;

f=fspecial('average', win_size);
mu1=conv2(img1, f, 'same');
mu2=conv2(img2, f, 'same');

rau1=conv2(img1.^2, f, 'same');
rau2=conv2(img2.^2, f, 'same');

sigma1=rau1-mu1.^2;
sigma2=rau2-mu2.^2;

diff1=(img1-mu1)./(eps+sqrt(sigma1));
diff2=(img2-mu2)./(eps+sqrt(sigma2));

max_disp=params.max_disp;
switch params.direction
    case -1
        disp_range=max_disp+1;
        pad_direct='pre';
    case 0
        disp_range=2*max_disp+1;
        pad_direct='both';
    case 1
        disp_range=max_disp+1;
        pad_direct='post';
end   

cost=zeros(nrow2, ncol2, disp_range);
diff2_pad=padarray(diff2, [0 max_disp], 0, pad_direct);

for d=1:disp_range
      temp=diff1.*diff2_pad(:, d:d+ncol2-1,:);
      cost(:,:,d)=-conv2(temp, f, 'same');
end
