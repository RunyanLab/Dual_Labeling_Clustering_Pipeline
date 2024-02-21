function [cell_stat,redcell_vect,Fall]= convert_to_isCell(Fall,redcell_vect)
% Function that converts cell indices from a list containing all ROIs
% identified by suite2p (iscell) to a list where only cells that were manually
% selected by the user in the suite2p GUI are included (iscell==1)
%
%INPUTS:
%   Fall: Matlab structure output by suite2p
%   redcell_vect: vector obtained from ROIs that were manually selected in
%       suite2p due to having red fluorescence 


%OUTPUTS:
%   cell_stat: structure containing information about each ROI that was 
%       manually selected to be a cell 
%   redcell_vect: list of redcells in iscell==1 coordinates  
%   Fall: updated matlab structure 

% Christian Potter - updated: 2/2/2024

%%
cell_stat=Fall.stat(Fall.iscell(:,1)==1);  

redcell_vect=redcell_vect(Fall.iscell(:,1)==1);

Fall.redcell_vect=redcell_vect; 

end

