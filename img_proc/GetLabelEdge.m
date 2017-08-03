function img_out=GetLabelEdge(img,label,varargin)
% Generate a image with label edges,
% Input:
%    img:the input img
%    label: the class label
%    varargin{1}: edge color
% Output:
%    img_with_edge: output image with color edge
% 2016-10-23, jlfeng
[nr,nc,nd]=size(img);
if (size(label,1)~=nr || size(label,2)~=nc)
    error('Input img and label have different size.')
end
if (nd==1)
    img_r=img;
    img_g=img;
    img_b=img;
elseif (nd==3)
    img_r=img(:,:,1);
    img_g=img(:,:,2);
    img_b=img(:,:,3);
end

if (nargin<3)
    edge_color=[255,0,0];
else
    edge_color=varargin{1};
end

dx=[-1, -1,  0,  1, 1, 1, 0, -1];
dy=[0, -1, -1, -1, 0, 1, 1,  1];

label_pad=ImgPad(label,2,0,1);

for px=2:nr+1
    for py=2:nc+1
        num_diff=0;
        for pk=1:8
            pxd=px+dx(pk);
            pyd=py+dy(pk);
            if (label_pad(px+(py-1)*(2+nr))~=label_pad(pxd+(pyd-1)*(2+nr)))
                num_diff=num_diff+ 1;
            end
        end
        if num_diff>1
            img_r(px-1,py-1)=edge_color(1);
            img_g(px-1,py-1)=edge_color(2);
            img_b(px-1,py-1)=edge_color(3);
        end
        
    end
end


img_out=cat(3,img_r,img_g,img_b);

