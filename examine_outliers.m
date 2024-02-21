function []=examine_outliers(red_vect,chosen_combination,threshold,meanwave_intensities,info,flatwave_identities,combination_results,combos)

% Function that displays the indices of outliers and how their intensities compare to centroids from 
% mCherry and tdTomato 

% INPUTS: 
% red_vect = logical vector indicating which cells in list of isCell == 1 is an interneuron
% chosen_combination = 
% threshold = exclusion threshold (always .7)
% intensities = vector of intensities at each wavelength 

% OUTPUTS:
% uses inspect_intensity to plot outliers 

% Christian Potter - last updated: 2/6/2024

%%
sub_intensities=meanwave_intensities(:,combos{chosen_combination}); 
silhouettes=combination_results.all_silhouettes{chosen_combination}; 
outliers=find(silhouettes<threshold);% find outliers in isred == 1 coordinates 

centroids=combination_results.centroids{chosen_combination}; 
ident=combination_results.identities{chosen_combination}; 

inspect_intensity(outliers,find(red_vect==1),sub_intensities,centroids,flatwave_identities,info,ident)

end
