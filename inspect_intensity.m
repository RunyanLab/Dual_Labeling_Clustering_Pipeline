function []=inspect_intensity(outliers,cell_ids,intensities,centroids,flatindentities,info,identities)
% use this function to look at cells of interest or the spectra of outliers
% in general 

% INPUTS: 
%   outliers = vector of outliers (in redvect == 1 coordinates)
%   cell_ids = vector of outliers (in iscell == 1 coordinates)
%   intensities = mean fluorescence values for given combination 
%   centroids = intensity values of each centroid 
%   flatidentities = list of wavelength + 'nm' for plotting 
%   info = structure with dataset information 
%   identities = cluster outcomes from selected combination 

% OUTPUTS: 
%   plot of outliers and centroids of each cluster 

% Christian Potter - Last updated 2/6/2024

%% MAKE TITLE / LEGEND AND SUBSELECT INTENSITY VALUES

titleaddon=[info.mouse,' ',info.date,': ','Outliers Below Threshold']; 

leg=cell(length(outliers)+2,1); % make legend 

for i = 1:length(outliers)
    leg{i+2}=['silhouette:',num2str(outliers(i)),' | cellid: ',num2str(cell_ids(outliers(i))),' | classified:',num2str(identities(outliers(i)))]; % make cell array for the legend 
end

leg{1}='mCherry Centroid';
leg{2}='TdTomato Centroid';

selected_intensities=intensities(outliers,:); %

selected_intensities=selected_intensities';

centroids=centroids';
%% PLOT NORMALIZED CENTROIDS AND OUTLIERS 
figure('Color','w')
hold on 
title(titleaddon)

if mean(centroids(1:2,1)) > mean(centroids(1:2,2))    
    plot(normc(centroids(:,1)),'LineWidth',3,'Color','r')
    hold on 
    plot(normc(centroids(:,2)),'LineWidth',3,'Color','g')
else
    plot(normc(centroids(:,2)),'LineWidth',3,'Color','r')
    hold on
    plot(normc(centroids(:,1)),'LineWidth',3,'Color','g')
end

plot(normc(selected_intensities),'LineWidth',1.3); 
xticks(1:size(intensities,2))
xticklabels(flatindentities(1:end))
legend(leg);
xlabel('Wavelengths')
ylabel('Normalized Intensity')

title(titleaddon)
