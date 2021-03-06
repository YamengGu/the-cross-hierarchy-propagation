# the-cross-hierarchy-propagation
This includes the MATLAB code script and related data file for the article "Brain activity fluctuations propagate as waves traversing the cortical hierarchy".  
Edited by Yameng Gu from the Pennsylvania State University.  
Please send questions or feedback to ymgu95@gmail.com.  

The input data from human is publicly available at http://www.humanconnectome.org/data.  
The input data from monkey is publicly available at http://neurotycho.org/anesthesia-and-sleep-task.  
The MATLAB package is used to read HCP cifit data into matlab: http://www.fieldtriptoolbox.org.  
The Connectome Workbench software is used to display the human brain surface. The software is open source and freely available at http://www.humanconnectome.org/software/connectome-workbench.  

The script folder includes:  
cal_corr_seg_human.m: the script to project human input data onto a direction and calculate time-position correlation across time segments.  
cal_corr_seg_monkey.m: the script to project monkey input data onto a direction and calcualte time-position correlation across time segments.  
cal_pd.m: the script to calculate the principal delay profile.  
FT_Filter_mulch2: filtering signal.  
function inpaint_nans can be found at https://www.mathworks.com/matlabcentral/fileexchange/4551-inpaint_nans.

The data folder includes:  
human_pd_unit_sec.dtseries.nii: the human principal delay profile with a unit of sec on the brain surface.  
surf_bottom_up_ave_zscore.dtseries.nii: the avearged surface segments with bottom-up propagations in human resting-state functional MRI. The segment is centered at the global peak and converted to z-scored map, with a length of 21 time points. The 11th time point represent time zero.  
surf_top_down_ave_zscore.dtseries.nii: the averages surface segments with top-down propagations in human resting-state functional MRI. 
volume_top_down_ave_zscore.zip: the averages volume segments with top-down propagations in human resting-state functional MRI. The segment is centered at the global peak and converted to z-scored map, with a length of 21 time points. The 11th time point represent time zero.  
volume_bottom_up_ave_zscore.zip: the averages volume segments with bottom-up propagations in human resting-state functional MRI. 
pg1.dtseries.nii: the first component of the principal gradient from Margulies et al, PNAS, 2016. For more components, please see https://github.com/NeuroanatomyAndConnectivity/gradient_analysis.

