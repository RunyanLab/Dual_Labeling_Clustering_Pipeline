function[final_red_vect,final_ident,final_intensities,final_silhouettes,excluded_cellids,final_iscell]=exclude_cells(exclude_redids,uncertain,final_red_vect,final_ident,final_intensities,final_silhouettes,Fall)

% Function that excludes outliers from clustering results  

% INPUTS: 
%   exclude_redids = list in isred == 1 index of cells to be excluded
%   uncertain = list in iscell == 1 coordinates of cells to be excluded for
%       being unclear if they are labeled red or not 
%   final_red_vect = logical vector indicating which neurons are
%       interneurons
%   final_ident = list of clustering labels 
%   final_intensities = list of intensity values for each cell included in
%       clustering
%   final_silhouettes = list of silhouette scores used in clustering 
%   Fall = suite2p structure containing imaging information 

% OUTPUTS: 
%   final_red_vect = updated logical vector of interneuron indices with
%       excluded cells removed 
%   final_ident = updated list of clustering outcomes with excluded cells
%       removed
%   final_intensities = updated list of intensities at each wavelength
%   final_silhouettes = updated list of silhouette scores
%   excluded_cellids = list of which cells were exluded in iscell == 1
%       coordinates 
%   final_iscell = updated list of which ROIs are actually cells 

% Christian Potter - last updated 2/6/2024


%% EXCLUDE CELLS FROM ALL FUNCTIONAL DATA
iscell=Fall.iscell(:,1); 

cellids_to_exclude=find(final_red_vect==1); % get list of red cells in iscell==1 coordinates

cellids_to_exclude=cellids_to_exclude(exclude_redids);%list of cells to be excluded 

cellids_to_exclude=[uncertain,cellids_to_exclude]; 
final_red_vect(cellids_to_exclude,:)=[]; 
final_ident(exclude_redids,:)=[];
final_intensities(exclude_redids,:)=[];
final_silhouettes(exclude_redids,:)=[];

s2pidstoexclude=nan(length(exclude_redids),1);

for i = 1:length(cellids_to_exclude)
    s2pidstoexclude(i)=convert_coordinate(cellids_to_exclude(i),'c2s',Fall);
end

iscell(s2pidstoexclude) = 0; 

final_iscell = iscell;

excluded_cellids = unique([cellids_to_exclude,uncertain]);

end
