
%% load matrix
clear all;
clc;
load('/path/to/pd.mat'); % load principal delay profile
load('/path/to/ave_sped.mat'); % load averaged speed matrix

%%
geodesic_distance = 80; % geodesic distance on the cortical surface between sensorimotor and DMN is 80 mm based on Margulies, PNAS, 2016

%%
tmp1 = max(pd)-min(pd);
tmp2 = (geodesic_distance/ave_sped)/tmp1;
pd_scaled = pd*tmp2;

