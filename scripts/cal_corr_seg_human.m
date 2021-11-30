

%% calculate time-position graph, time-position correlation, and speed of propagation along a specific brain map
clear all;
clc;
load('/path/to/pg1.mat'); % load the brain map: pg1 (principal delay profile)

%% load data
system('wb_command -cifti-smoothing input_data.dtseries.nii 2 2 COLUMN input_data_smoothed.dtseries.nii -left-surface /path/to/surf_structure/S900.L.inflated_MSMAll.32k_fs_LR.surf.gii -right-surface /path/to/surf_structure/S900.R.inflated_MSMAll.32k_fs_LR.surf.gii'); % spatially smoothing input data
cii_3 = ft_read_cifti('input_data_smoothed.dtseries.nii');
dtser = cii_3.dtseries(1:32492*2,:);
dtser(isnan(dtser(:,1)),:) = [];
epi1msk = FT_Filter_mulch2(dtser',[0.001 .1]/.694444)'; % temporally smoothing data
epi1msk = zscore(epi1msk')';
gs_LR1 = mean(epi1msk); % calculate the global mean of input data

num_bins = 70; # number of bins

pgd1 = discretize(pg1,prctile(pg1,0:100/num_bins:100));
pgd1 = pgd1-min(pgd1)+1;
tw1 = grpstats(epi1msk,pgd1); % tw1: time-position graph along the brain map

%% find delay of local peaks relative to global peak at each position: idx_tem_prin
[gls_neg_pk,locs] = findpeaks(-double(gs_LR1));
idx_tem_prin = zeros(size(tw1,1),size(locs,1)-1);

for li = 1:size(locs,1)-1

    clear tmp_prin 
    tmp_prin = tw1(:,locs(li):locs(li+1));     
    for lj = 1:size(tw1,1)
        
    tmp2_prin = tmp_prin(lj,:);

      
    [pks_prin, a_prin] = findpeaks(double(tmp2_prin));

    thre1 = 0;
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
sz = diff(locs);
rval_prin_2 = zeros(1,size(locs,1)-1);

for ln = 1:size(locs,1)-1
clear x_ax
x_ax = (0:(sz(ln)-1)/size(idx_tem_prin,1):(sz(ln)-1));
x_ax = x_ax(1:end-1);

if sum(isnan(idx_tem_prin(:,ln)))>num_bins*0.2
    rval_prin_2(ln) = nan;
else    
[rval_prin_2(ln),~] = corr((x_ax)',idx_tem_prin(:,ln),'rows','pairwise');
end

end

% calcualte propagation speed
x_ax = 1:num_bins;
idx = isnan(idx_tem_prin);
coefficients = polyfit(idx_tem_prin(~idx),x_ax(~idx)', 1);
geodesic_distance = 80; % geodesic distance on the cortical surface between sensorimotor and DMN is 80 mm based on Margulies, PNAS, 2016
tr_data = 0.72; % TR of used HCP data is 0.72
sped_seg = abs(coefficients(1))*geodesic_distance/num_bins/tr_hcp;


%% save generated matrices
save('/path/to/mats/results.mat','locs','tw1','idx_tem_prin','rval_prin_2','sped_seg');




