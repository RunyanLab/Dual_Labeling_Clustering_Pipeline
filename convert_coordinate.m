function[converted_coord]=convert_coordinate(idx,conv_type,Fall)
% Function that converts between 3 kinds of cellID coordinates: 
% 1. s2p index containing all ROIs
% 2. iscell == 1 index, containing only manually selected ROIs that appear
%   to be cells 
% 3. isred == 1 index, containing only cells that appear to be red from iscell == 1 
% Useful if you are trying to look up a cell in suite2p


% INPUTS:
%   idx = cell ID to convert
%   conv_type = string that specifies the index
%   Fall = structure output from suite2p containing information for making
%       the indices 

% OUTPUTS: 
%   converted_coord = index of cellID in new coordinate system 

%** RED_CELL_VECT IS A VECTOR OF LENGTH sum(ISCELL==1) 
% WILL NOT WORK AFTER EXCLUSION STEP
% COORDINATES ALWAYS IN MATLAB COORDINATES, SUBTRACT 1 FOR S2P


converted_coord=nan(length(idx),1);

iscell=Fall.iscell(:,1);
red_cell_vect=Fall.redcell_vect;

s2p_all=1:length(iscell); % s2p coordinates

s2plist_cells=find(iscell==1); % s2p coordinates where iscell==1
cellist_red=find(red_cell_vect==1); % iscell coordinates where isred==1
s2plist_red=s2plist_cells(cellist_red);%s2p coordinates where isred==1

for i = 1:length(idx)
    if strcmp(conv_type,'s2c')
        converted_coord(i)= find(s2plist_cells==idx); % s2p => iscell 
    
    elseif strcmp(conv_type,'s2r')
        temp=s2plist_cells(idx); %to get to iscell
        converted_coord(i)=find(s2plist_red==temp); %s2p ==> isred
    
    elseif strcmp(conv_type,'c2s')
        converted_coord(i)= s2plist_cells(idx); % iscell => s2p
    
    elseif strcmp(conv_type,'c2r')
        converted_coord(i)=find(s2plist_red==idx); %iscell => isred  
        
    elseif strcmp(conv_type,'r2c')
        converted_coord(i)=s2plist_red(idx); % isred => iscell 
    
    elseif strcmp(conv_type,'r2s')
        temp=s2plist_red(idx);
        converted_coord(i)= find(s2plist_cells==temp); % isred => s2p 
    
    end



end


    