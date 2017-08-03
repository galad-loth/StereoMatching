function cost=MatchCostAD(img1, img2, params)
[nrow2, ncol2, ndim2]=size(img2);
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

switch lower(params.type)
    case {'ad'}
        cost_thr=1e10;
        cost_type=1;
    case 'sd'
        cost_thr=1e10;
        cost_type=2;
    case {'tad'}
        cost_thr=params.cost_thr;
        cost_type=1;
    case {'tsd'}
        cost_thr=params.cost_thr;
        cost_type=2;       
end

cost=zeros(nrow2, ncol2, disp_range);
img2_pad=padarray(img2, [0 max_disp], 0, pad_direct);

for d=1:disp_range
    if ndim2==1
        temp=img1-img2_pad(:, d:d+ncol2-1);
        if cost_type==2
            cost(:,:,d)=temp.^2;
        else
            cost(:,:,d)=abs(temp);
        end
    else
        temp=img1-img2_pad(:, d:d+ncol2-1,:);
        if cost_type==2
            cost(:,:,d)=sum(temp.^2,3); 
        else
            cost(:,:,d)=sum(abs(temp),3); 
        end
    end    
end
cost=min(cost, cost_thr);

