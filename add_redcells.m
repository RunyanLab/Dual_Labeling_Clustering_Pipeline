function[updated_redcells]=add_redcells(redcell_vect,toadd)
% simple function that adds interneurons to list of current interneurons 

% INPUTS: 
    % redcell_vect = vector of redcells in iscell == 1 coordinates
    % toadd = list to change values of redcell_vect to 1

% OUTPUTS:
    % updated_redcells = updated list of red cells 

% CTP - updated 2/4/2024

for i =1:length(toadd)
    redcell_vect(toadd(i))=1;
end


updated_redcells=redcell_vect; 

