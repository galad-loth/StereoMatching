function img_out=ImgFiltering(img_in, type, varargin)
[~, ~, nchl]=size(img_in);
if nchl==1
    img_out=SingleChannelFiltering(img_in, type, varargin{:});
else
    img_out=img_in;
    for k=1:nchl        
         img_out(:,:,k)=SingleChannelFiltering(img_in(:,:,k), type, varargin{:});
    end
end


function res=SingleChannelFiltering(img, type, varargin)
switch lower(type)
    case 'gaussian'
        f=fspecial('gaussian',varargin{1},varargin{2});
        res=conv2(img, f, 'same');
    case 'log'
        f=fspecial('gaussian',[varargin{1},varargin{1}],varargin{2});
         res=conv2(img, f, 'same');
    case 'mean'
         f=fspecial('average',varargin{1});
         res=conv2(img, f, 'same');
    case 'med'
         res=medfilt2(img, [varargin{1}, varargin{1}]);
    case 'ord'
        res=ordfilt2(img, varargin{1}, varargin{2});
end

        