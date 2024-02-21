function [meanwave_intensities,wavelength_identities]=avg_acrosspocks(intensities,info)
% function to average of images taken at powers at a given
% wavelength 

% INPUTS: 
%   intensities = matrix of dimensions: neurons x intermixed pockels and wavelengths 
%   info = structure containg information about imaging parameters

% OUTPUTS: 
%   meanwave_intensities = intensities averaged across 
%   wavelength_identities = cell array with strings describing each
%       wavelength for plotting 

% Christian Potter - updated 2/5/2024

subset=info.subset_pockels; 
numpocks=length(info.pockels); 
numwaves=size(intensities,2)/numpocks;
meanwave_intensities=nan(size(intensities,1),numwaves);

%% MAKE LIST OF WAVELENGTHS USED (WITHOUT POWERS ATTACHED)
wavelength_identities=cell(numwaves,1);

for i = 1:length(wavelength_identities)
    combined_str=strcat(num2str(info.wavelengths(i)),' nm');
    wavelength_identities{i}=combined_str;
end

%% AVERAGE ACROSS POCKELS, TAKING A SUBSET IF NEEDED 

boundaries=1:numpocks:size(intensities,2)+1;

for i = 1:numwaves
    curpocks=intensities(:,(boundaries(i):boundaries(i+1)-1));
    meanwave_intensities(:,i)=mean(curpocks(:,subset),2);
end

end 
