function[img]=get_images(wsFall,Fall,red_wavelength_stack)
% Function that converts cell indices from a list containing all ROIs
% identified by suite2p (iscell) to a list where only cells that were manually
% selected by the user in the suite2p GUI are included (iscell==1)
%
%INPUTS:
%   wsFall: Matlab structure output by wavelength series code 
%   Fall: Matlab structure output by suite2p
%   red_wavelength_stack: pockels x wavelength x Y pixels x X pixels matrix  


%OUTPUTS:
%   img: Structure containing all reference images used by the rest of the
%   pipeline

% Christian Potter - updated: 2/2/2024

%% Extract images from suite2p structures 
wsRef=wsFall.ops.meanImg; %wavelength-series ref image (can make whatever you want)

fRef=Fall.ops.meanImg_chan2; % functional ref image
fRef_red=Fall.ops.meanImgE; % functional imaging 
[max_proj,sum_proj]=make_maxproj(red_wavelength_stack); % make a max_projection and sum_projection for two different images that reveal red cells
greenImage=Fall.ops.meanImg; % image of green channel for reference 

%% Create short and long wavelength images here (adjust as necessary given your wavelength series)

shortImage=squeeze(mean(red_wavelength_stack(:,1:3,:,:),1)); % average of short wavelength images
shortImage=squeeze(mean(shortImage,1));

longImage=squeeze(mean(red_wavelength_stack(:,12:14,:,:),1)); % average of long wavelength images
longImage=squeeze(mean(longImage,1));

%% Make img structure 
% contains all images used by the rest of the pipeline 

img.wsRef=wsRef;
img.fRef=fRef; 
img.fRef_red=fRef_red;
img.short=shortImage; 
img.long=longImage; 
img.green=greenImage; 
img.max_proj=max_proj; 
img.sum_proj=sum_proj; 

end
