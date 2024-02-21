function [fullD_results] = cluster_masks (intensities,red_vect,meanwave_identities,info,img,red_cellocs)
% Function that clusters based on all imaged wavelengths and plots results
% of clustering on reference image 

% INPUTS: 
%   intensities = matrix of dimensions cell x wavelength containing the
%       information about the mean intensity of each ROI at each wavelength 
%   red_vect = vector containing information about which cells of 
%       iscell == 1 indices is a red cell 
%   meanwave_identitites = list containg xaxis labels for plotting for each
%       wavelength 
%   info = structure with imaging info
%   img = structure with reference images 
%   red_cellocs = array with dimensions ypix x xpix x cellid containing the
%       pixels in the mask of each red cell 

% OUTPUTS: 
%   fullD_results = structure containing the clustering results, including
%       the silhouette scores, centroids of the clusters describing the
%       mean intensitiy values at each wavelength across all of the ROIs
%       in a cluster 

%   Christian Potter - last updated: 2/5/2024

mean_image=img.sum_proj; % change if you want a different reference image 

mouse=info.mouse;
date=info.date; 

cell_idx=1:length(red_vect);

t=[mouse,' ',date,': All Wavelengths'];
%% NORMALIZE INTENSITIES / RUN KMEANS

red_idx=cell_idx(red_vect);
norm_intensities=normr(intensities);
[ident,centroids,sumd,alldistances]= kmeans(norm_intensities, 2,'Replicates',100,'MaxIter',10000);
%% OUTPUT SILHOUETTE SCORES

silhouettes=get_silhouettes(alldistances,ident);
group1=norm_intensities(ident==1,:);
group2= norm_intensities(ident==2,:);

if mean(group1(:,1)) > mean(group2(:,1))
    g1_ident='mCherry';
    g2_ident='tdTomato';
else
    g1_ident='tdTomato';
    g2_ident='mCherry';
end

ident_order={g1_ident,g2_ident};
%% MAKE FIGURE DISPLAYING WHICH CELLS WERE SORTED INTO WHICH CLUSTER 
figure('Color','w')
imshow(mean_image);
caxis([0 mean(mean(mean_image))*4])
hold on 
textshiftx=5; % can change if you want the text offset to be different 
textshifty=5;

for i = 1: size(red_cellocs,3)
    [cury,curx]=find(red_cellocs(:,:,i));
    
        if ident(i)==1 && strcmp(g1_ident,'mCherry')
                hold on 
                plot(curx,cury,'.',"Color",'r')
                text(mean(curx)+textshiftx,mean(cury)+textshifty,num2str(red_idx(i)),'Color','r')
                hold off
                            
        elseif ident(i)==1 && strcmp(g1_ident,'tdTomato')
                hold on; 
                plot(curx,cury,'.',"Color",'g')
                text(mean(curx)+textshiftx,mean(cury)+textshifty,num2str(red_idx(i)),'Color','g')
                hold off
           
        elseif ident(i)==2 && strcmp(g2_ident,'mCherry')
                hold on 
                plot(curx,cury,'.',"Color",'r')
                text(mean(curx)+textshiftx,mean(cury)+textshifty,num2str(red_idx(i)),'Color','r')
                hold off 

        elseif ident(i)==2 && strcmp(g2_ident,'tdTomato')
                hold on
                plot(curx,cury,'.',"color",'g')
                text(mean(curx)+textshiftx,mean(cury)+textshifty,num2str(red_idx(i)),'Color','g')
                hold off 
        end  
end
title(t);
subtitle('mcherry = red || tdtomato= green');
%% PLOT INTENSITIES BY CLUSTER 
figure('Color','w');
hold on
for clust = 1:2
    
    subplot(2,1,clust)
    group = norm_intensities(ident==clust,:)';
    plot(group,'LineWidth',1);
    xticks(1:size(norm_intensities,2))
    xticklabels(meanwave_identities(1:end))
    %xline(1:size(norm_intensities,2),'LineStyle','--')
    ylabel('Normalized Intensity')

    if clust==2
        xlabel ('Wavelength')
    end
 
    if clust==1
       title(g1_ident)
    else
       title(g2_ident)
    end
end
sgtitle(t)
%% CHANGE IDENTITY VALUES SO THAT MCHERRY ALWAYS EQUALS 1

if strcmp(ident_order{1},'tdTomato')
    for id= 1:length(ident)
        
        if ident(id)==1
            ident(id)=2;
        elseif ident(id)==2
            ident(id)=1;
        end
    end
end
%% MAKE STRUCTURE
fullD_results.ident=ident; 
fullD_results.centroids=centroids; 
fullD_results.sumd=sumd; 
fullD_results.alldistances=alldistances; 
fullD_results.silhouettes=silhouettes; 
end



