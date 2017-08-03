function d=DisparityOptGC(cost, img1, img2, params)

glbopt_params=params.glbopt_params;
cost_params=params.cost_params;
[nrow, ncol, nchl]=size(cost);

data_cost=reshape(cost, [nrow*ncol, nchl]);
data_cost=int32(data_cost'*glbopt_params.alpha);
smooth_cost=GetSmoothCost(nchl, 'potts');
neighbor_weight=GetNeighborWeight(img1,glbopt_params.sigma, glbopt_params.beta);

obj_gco = GCO_Create(size(data_cost,2), size(data_cost,1));  
GCO_SetDataCost(obj_gco, data_cost);
GCO_SetSmoothCost(obj_gco, smooth_cost);
GCO_SetNeighbors(obj_gco, neighbor_weight);
GCO_Expansion(obj_gco);
gc_label=GCO_GetLabeling(obj_gco);

gc_label=reshape(gc_label, [nrow, ncol]);
if cost_params.direction==1
    d=gc_label-1;   
elseif cost_params.direction==0
    d=gc_label-1- cost_params.max_disp;
else
    d=cost_params.max_disp-gc_label+1;
end

function smooth_cost=GetSmoothCost(nchl, type, varargin)
switch type
    case 'potts'
        smooth_cost=ones(nchl, nchl)-eye(nchl);
    case 'linear'
        max_cost=varargin{1};
        smooth_cost=zeros(nchl, nchl);
        for k=1:nchl
            smooth_cost(k,:)=min(max_cost, abs((1:nchl)-k));
        end        
end


function neighbor_weight=GetNeighborWeight(img, sigma, beta)
[nrow, ncol, nchl]=size(img);
npixel=nrow*ncol;
img_data=reshape(img, [npixel, nchl]);
% neighbor_weight=zeros(npixel,npixel);

nzmax=(nrow-1)*(ncol-1)*2;
temp=zeros(nzmax, 3);
idx_temp=1;

for i=1:nrow-1
    for j=1:ncol-1
        idx_c=i+(j-1)*nrow;
        idx_n1=i+1+(j-1)*nrow;
        idx_n2=i+j*nrow;
        d1=sum((img_data(idx_c,:)-img_data(idx_n1,:)).^2);
        d2=sum((img_data(idx_c,:)-img_data(idx_n2,:)).^2);
        temp(idx_temp,1)=idx_c;
        temp(idx_temp,2)=idx_n1;
        temp(idx_temp,3)=ceil(beta*exp(-d1/(2*sigma*sigma)));
        temp(idx_temp+1,1)=idx_c;
        temp(idx_temp+1,2)=idx_n2;
        temp(idx_temp+1,3)=ceil(beta*exp(-d2/(2*sigma*sigma)));
%         temp(idx_temp+2,1)=idx_n1;
%         temp(idx_temp+2,2)=idx_c;
%         temp(idx_temp+2,3)= temp(idx_temp,3);
%         temp(idx_temp+3,1)=idx_n2 ;
%         temp(idx_temp+3,2)=idx_c;
%         temp(idx_temp+3,3)= temp(idx_temp+1,3);
        idx_temp=idx_temp+2;
%         neighbor_weight(idx_c, idx_n1)=exp(-d1/(2*sigma*sigma));
%         neighbor_weight(idx_c, idx_n2)=exp(-d2/(2*sigma*sigma));
%         neighbor_weight(idx_n1, idx_c)=neighbor_weight(idx_c, idx_n1);
%         neighbor_weight(idx_n2, idx_c)=neighbor_weight(idx_c, idx_n2);
    end
end

neighbor_weight=sparse(temp(:,1), temp(:,2), temp(:,3), npixel, npixel, size(temp, 1));






