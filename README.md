# the-cross-hierarchy-propagation
This includes the MATLAB code for the article "Brain activity fluctuations propagate as waves traversing the cortical hierarchy".  
Edited by Yameng Gu from the Pennsylvania State University.  
Please send questions or feedback to ymgu95@gmail.com.  

The input data from human is publicly available at http://www.humanconnectome.org/data.  
The input data from monkey is publicly available at http://neurotycho.org.  
The MATLAB package is used to read HCP cifit data into matlab: http://www.fieldtriptoolbox.org.  
The Connectome Workbench software is used to display the human brain surface. The software is open source and freely available at http://www.humanconnectome.org/software/connectome-workbench.  

The code files included:  
cal_corr_seg_human.m: the script to project human input data onto a direction and calculate time-position correlation across time segments.  
cal_corr_seg_monkey.m: the script to project monkey input data onto a direction and calcualte time-position correlation across time segments.  
cal_pd.m: the script to calculate the principal delay profile.  

