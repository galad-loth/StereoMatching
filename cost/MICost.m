function cost=MICost(img1, img2, p, params)

[nrow2, ncol2, ndim2]=size(img2);
[nrowp, ncolp]=size(p);
img1=max(0, min(round(img1), nrowp-1));
img2=max(0, min(round(img2), ncolp-1));

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

p1=sum(p,1);
p2=sum(p,2);
f=fspecial('gaussian', 5, 1.3);
ps=conv2(p, f, 'same');
h12=conv2(-log(ps+eps), f, 'same');

f=sum(f,1);
ps=conv(p1, f, 'same');
h1=conv(-log(ps+eps),f,'same');

ps=conv(p2, f, 'same');
h2=conv(-log(ps+eps),f,'same');

cost=zeros(nrow2, ncol2, disp_range);
img2_pad=padarray(img2, [0 max_disp], 0, pad_direct);
for d=1:disp_range
    temp=img1+1+img2_pad(:, d:d+ncol2-1)*nrowp;
    cost(:,:,d)=reshape(h12(temp(:))-h1(img1(:)+1)'-h2(img2(:)+1),[nrow2 ncol2]);
end
