function [info] = p_w_identities(info)

% Function that takes vector of integers for each pockels value used as
% well as vector of integers for each wavelenth that was used 

% INPUTS: 
    % info = structure containing dataset information 

% OUTPUTS:
    % info = updated structure containing the wavelength information 
% 
% Christian Potter - updated: 2/2/2024

%% POPULATE "IDENTITIES" 

nwaves = length(info.wavelengths);
npocks = length(info.pockels);
identities= cell(npocks,nwaves);

for i = 1:npocks
    for t= 1:nwaves
        curwave=num2str(info.wavelengths(t));
        curpock=num2str(info.pockels(i));
        identities{i,t}= strcat(curwave,' nm ','@',curpock);
    end

end

info.identities=identities; 

end

