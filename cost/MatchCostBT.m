function cost=MatchCostBT(img1, img2, params)
[nrow2, ncol2]=size(img2);
imgs1=GetSampledImg(img1);
imgs2=GetSampledImg(img2);

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
imgs2_pad=padarray(imgs2, [0 max_disp 0], 0, pad_direct);

for d=1:disp_range
    temp=10e8*ones(nrow2, ncol2);
    for i=1:3
         temp=min(temp, abs(img1-imgs2_pad(:, d:d+ncol2-1, i)));
         temp=min(temp, abs(imgs1(:,:,i)-imgs2_pad(:, d:d+ncol2-1, 2)));
    end
    cost(:,:,d)=temp;
end


function imgs=GetSampledImg(img)
[nrow, ncol]=size(img);
imgs=zeros(nrow, ncol,3);
imgs(:,:,1)=img;
imgs(:,:,2)=img;
imgs(:,:,3)=img;
imgs(:,1:ncol-1,1)=(img(:,1:ncol-1)+img(:,2:ncol))/2;
imgs(:,2:ncol,3)=(img(:,1:ncol-1)+img(:,2:ncol))/2;


