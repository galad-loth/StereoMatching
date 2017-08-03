function cost_aggr=CostAggrBilateral(cost, img1, img2, params)
[nrow1, ncol1, nchl1]=size(img1);
[nrow2, ncol2, nchl2]=size(img2); 
cost_params=params.cost_params;
aggr_params=params.aggr_params;

max_disp=cost_params.max_disp;
win_halfsize=aggr_params.win_halfsize;
sigma_s=aggr_params.sigma_spatial;
sigma_c=aggr_params.sigma_color;

switch cost_params.direction
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

img2_pad=padarray(img2, [0 max_disp], 0, pad_direct);

[xx, yy]=meshgrid(-win_halfsize:win_halfsize, -win_halfsize:win_halfsize);
win_size=win_halfsize*2+1;
ws=exp(-(xx.^2+yy.^2)/(2*sigma_s*sigma_s));

cost_aggr=zeros(size(cost));
for d=1:disp_range
    disp(['Processing Cost Channel ', num2str(d)]);
    for i=1:(nrow1-win_size)
        for j=1:(ncol1-win_size)
            img_sub1=img1(i:i+win_size-1, j:j+win_size-1, :);
            img_sub2=img2_pad(i:i+win_size-1, j+d:j+d+win_size-1, :);
            dist1=zeros(win_size, win_size);
            dist2=zeros(win_size, win_size);
            for c=1:nchl1
                dist1=dist1+(img_sub1(:,:,c)-img_sub1(win_halfsize+1, win_halfsize+1, c)).^2;
                dist2=dist2+(img_sub2(:,:,c)-img_sub2(win_halfsize+1, win_halfsize+1, c)).^2;
            end
            wc1=exp(-dist1/(nchl1*2*sigma_c*sigma_c));
            wc2=exp(-dist2/(nchl1*2*sigma_c*sigma_c));
            w=wc1.*wc2.*ws; 
            cost_sub=cost(i:i+win_size-1, j:j+win_size-1,d).*w;
            cost_aggr(i+win_halfsize, j+win_halfsize,d)=sum(cost_sub(:))/sum(w(:));            
        end
    end
end
    




