function[final_redcells]=sub_redcells(redcell_vect,tosubtract)
% simple function that removes interneurons to list of current interneurons 

% INPUTS: 
    % redcell_vect = vector of redcells in iscell == 1 coordinates
    % tosubtract = list to change values of redcell_vect to 1

% OUTPUTS:
    % updated_redcells = updated list of red cells 

% Christian Potter - updated 2/4/2024

for i =1:length(tosubtract)
    redcell_vect(tosubtract(i))=0;
end

final_redcells=redcell_vect; 

end