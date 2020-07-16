
%% calculate time-position correlation along a specific brain map
clear all;
clc;
load('/path/to/pd1.mat'); % load the brain map: pd1
load('/path/to/epi.mat'); % load monkey bandlimited power as input data: time points*electrode number

%% find delay of local peaks relative to global peak at each position: idx_tem_prin
[Y,I] = sort(pd1);
tw1 = epi(:,I)';
[gls_neg_pk,locs] = findpeaks(-double(mean(epi)));
idx_tem_prin = zeros(size(tw1,1),size(locs,2)-1);
thre1 = 0;
for li = 1:size(locs,2)-1
    
    clear tmp_prin 
    tmp_prin = tw1(:,locs(li):locs(li+1));
     
    for lj = 1:size(tw1,1)
        
    tmp2_prin = tmp_prin(lj,:);
      
    [pks_prin, a_prin] = findpeaks(double(tmp2_prin));
    
    if isempty(a_prin)
        idx_tem_prin(lj,li) = nan;
    elseif size(a_prin,2)>1
        [valmax1,id_prin] = max(pks_prin);
        if valmax1<=thre1
        idx_tem_prin(lj,li) = nan;
        else
        idx_tem_prin(lj,li) = a_prin(id_prin);
        end
    elseif pks_prin>thre1
        idx_tem_prin(lj,li) = a_prin; 
    else
        idx_tem_prin(lj,li) = nan;
    end
                
    end
end

%% calculate time-position correlation at each segment: rval_prin_2
rval_prin_2 = zeros(1,size(idx_tem_prin,2));

for li = 1:size(idx_tem_c_rota_larg,2)

if sum(isnan(idx_tem_prin(:,li)))>size(tw1,1)*0.2
    rval_prin_2(li) = nan;
else    
[rval_prin_2(li),~] = corr((1:128)',idx_tem_prin(:,li),'rows','pairwise');
end


end

%% save generated matrices
save('/path/to/mats/results.mat','locs','tw1','idx_tem_prin','rval_prin_2');

