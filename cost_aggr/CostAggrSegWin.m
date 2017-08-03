function cost_aggr=CostAggrSegWin(cost, params)

win_halfsize=params.win_halfsize;
lambda=params.lambda;
seg_label=params.seg_label;
[nrow, ncol, nchl]=size(cost);
if length(seg_label(:)) ~= nrow*ncol
    error('the size of seg_label is not equal to the size of cost')
end

win_size=win_halfsize*2+1;
cost_aggr=zeros(size(cost));
for i=1:(nrow-win_size)
      for j=1:(ncol-win_size)
        w=ones(win_size, win_size);
        seglabel_sub=seg_label(i:i+win_size-1, j:j+win_size-1);
        w(seglabel_sub~=seglabel_sub(win_halfsize+1, win_halfsize+1))=lambda;
        for d=1:nchl
            cost_sub=cost(i:i+win_size-1, j:j+win_size-1,d).*w;
            cost_aggr(i+win_halfsize, j+win_halfsize,d)=sum(cost_sub(:))/sum(w(:));       
        end
      end
end



% min_label=min(seg_label);
% max_label=max(seg_label);
% cost=reshape(cost, [nrow*ncol, nchl]);
% for k=min_label:max_label
%     idx=seg_label==k;
%     for i=1:nchl
%         cost(idx,i)=mean(cost(idx,i));
%     end
% end

% cost_aggr=reshape(cost,[nrow, ncol, nchl]);


