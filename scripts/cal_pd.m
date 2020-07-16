

%% calculate the principal delay profile
clear all;
clc;
load('/path/to/epi.mat'); % load input data epi: vertex or electrode*time points

%% calculate delay profile across time segments: idx_dly
[gls_neg_pk,locs] = findpeaks(-double(mean(epi)));
idx_dly = zeros(size(epi,1),size(locs,2)-1);

for li = 1:size(locs,2)-1
    
    clear tmp_prin 
    tmp_prin = epi(:,locs(li):locs(li+1));
    % locate max peaks in each bin/electrode
    for lj = 1:size(epi,1)        
    tmp2_prin = tmp_prin(lj,:);      
    [pks_prin, a_prin] = findpeaks(double(tmp2_prin));
    thre1 = 0;
    
    % find location of largest peak in each bin/electrode
    if isempty(a_prin)
        idx_dly(lj,li) = nan;
    elseif size(a_prin,2)>1
        [valmax1,id_prin] = max(pks_prin);
        if valmax1<=thre1
        idx_dly(lj,li) = nan;
        else
        idx_dly(lj,li) = a_prin(id_prin);
        end
    elseif pks_prin>thre1
        idx_dly(lj,li) = a_prin; 
    else
        idx_dly(lj,li) = nan;
    end
    
    end
end

%% applying SVD on delay profiles to calculate the principal delay profile: pd

% fill nan
seg_all = idx_dly;
seg_all2 = [];
for li = 1:size(seg_all,2)
    temp1 = seg_all(:,li);
    if sum(isnan(temp1))<size(seg_all,1)*0.2
        seg_all2 = cat(2,seg_all2,inpaint_nans(temp1,5));
    end    
end

% apply svd
delay_test3 = seg_all2 - repmat(mean(seg_all2),size(seg_all,1),1);
[U,S,V] = svd(delay_test3);
pd= zeros(size(U,1),size(V,1));
for li = 1:size(pd,2)
pd(:,li) = U(:,li)*S(li,li)*abs(V(:,li));     
end

% variance explained for each components
temp2 = diag(S);
var_exp = temp2.^2/sum(temp2.^2);


