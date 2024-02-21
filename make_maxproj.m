function[max_proj,sum_proj]=make_maxproj(red_wavelength_stack)
% Function that makes max projection and summed projection out of the obtained wavelength series

% INPUTS: 
%   red_wavelength stack = wavelength series 

% OUTPUTS:
%   max_proj = max projection 
%   sum_proj = summed projection 

% Christian Potter - last updated 2/6/2024

%%
maxpocks=squeeze(max(red_wavelength_stack,[],1));
max_proj=squeeze(max(maxpocks,[],1));

sumpocks=squeeze(sum(red_wavelength_stack,1));
sum_proj=squeeze(sum(sumpocks,1));

end

