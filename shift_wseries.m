function [shift]=shift_wseries(img)

% Function that shifts the coordinates of the wavelength series so that it
% is overlapping with the registration that occurs in the functional
% wavelength series 

% INPUTS: 
    % img = structure with all reference images 

% OUTPUTS: 
    % shift = vector with coordinate shift for X and Y dimensions

% Christian Potter - updated: 2/2/2024

%%
yr= nan(512,1023);% each row is the xcorr of the y from each image
ylag=nan(1023,1); % just a list of the lags that can be overriden every time in the for loop 
xr= nan(512,1023);% xcorr between the  
xlag=nan(1023,1);

for idx=1:512
    [xr(idx,:),xlag(:)]=xcorr(img.wsRef(idx,:),img.fRef(idx,:));
    [yr(idx,:),ylag(:)]=xcorr(img.wsRef(:,idx),img.fRef(:,idx));
end

xr=squeeze(mean(xr,1));
yr=squeeze(mean(yr,1));

xshift=find(xr==max(xr)); % find coordinate where the max xcorr is 
yshift=find(yr==max(yr)); 

xshift=xlag(xshift); %index into the lags to determine how much of a pixel shift that is 
yshift=ylag(yshift);

shift=[xshift, yshift]; 

end

