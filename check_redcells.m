function[]= check_redcells(redcell_vect,cell_stat,img,thresholds,shift)
% Function that plots interneurons and pyramidal neurons on the short and
% long wavelength images to make sure only the interneurons (mask outlines
% labeled in red) are plotted on bright spots. 

% INPUTS: 
    % redcell_vect = logical vector indicating a cell is an interneuron in iscell == 1 coordinates
    % cell_stat = contains the information about masks of each cell
    % img = structure with reference images
    % thresholds = adjust the brightness of each background
    % shift = correction between different registrations of wavelength
    %   series and functional imaging 

% OUTPUTS: 
    % currently labeled interneurons are plotted in red and currently
    % labeled pyramidal neurons are plotted in green over a long wavelength
    % and short wavelength image 

% Christian Potter - Last updated 2/4/2024

%% MAKE VARIABLES

xshift=shift(1);
yshift=shift(2); 
cellstat_ids=1:length(cell_stat);
%% PLOT INTERNEURONS ON SHORT WAVELENGTH IMAGE 
figure
subplot(1,2,1)

imshow(img.short)
caxis([0 max(max(img.short))/thresholds(1)])
hold on 

red_stat=cell_stat(redcell_vect); 
red_ids=cellstat_ids(redcell_vect);

for i = 1:length(red_stat)
    curstat=red_stat{i};
    xpix=double(curstat.xpix(curstat.soma_crop==1));
    ypix=double(curstat.ypix(curstat.soma_crop==1));
    
    xpix=xpix+xshift;
    ypix=ypix+yshift;

    xcoords=nan(2*range(ypix)+1,1);
    ycoords=nan(2*range(ypix)+1,1);
    ycl=unique(ypix);% y coords list 
    [ycl,~]=sort(ycl);

    for j=1:range(ypix)
        
        curx=xpix(ypix==ycl(j));
        xcoords(j)=min(curx);
        xcoords((end-1)-(j-1))=max(curx);
        ycoords(j)=ycl(j);
        ycoords((end-1)-(j-1))=ycl(j);
          
    end
    ycoords(end)=ycoords(1);
    xcoords(end)=xcoords(1);

    plot(double(xcoords),double(ycoords),'r','LineWidth',2)
    text(mean(xpix)+5,mean(ypix)+5,num2str(red_ids(i)),'Color','r')
 
end

%% PLOT PYRAMIDAL CELLS ON SHORT WAVELENGTH IMAGE 

green_stat=cell_stat(redcell_vect==0); 

green_ids=cellstat_ids(redcell_vect==0);


for i = 1:length(green_stat)
    curstat=green_stat{i};
    xpix=double(curstat.xpix(curstat.soma_crop==1));
    ypix=double(curstat.ypix(curstat.soma_crop==1));
    
    xpix=xpix+xshift;
    ypix=ypix+yshift;

    xcoords=nan(2*range(ypix)+1,1);
    ycoords=nan(2*range(ypix)+1,1);
    ycl=unique(ypix);% y coords list 
    [ycl,~]=sort(ycl);
    if length(ycl)<range(xpix)
        for j=1:length(ycl)
        
            curx=xpix(ypix==ycl(j));
            xcoords(j)=min(curx);
            xcoords((end-1)-(j-1))=max(curx);
            ycoords(j)=ycl(j);
            ycoords((end-1)-(j-1))=ycl(j);    
        end
    else
        for j=1:range(ypix)
        
            curx=xpix(ypix==ycl(j));
            xcoords(j)=min(curx);
            xcoords((end-1)-(j-1))=max(curx);
            ycoords(j)=ycl(j);
            ycoords((end-1)-(j-1))=ycl(j);    
        end
    end
    ycoords(end)=ycoords(1);
    xcoords(end)=xcoords(1);

    plot(double(xcoords),double(ycoords),'g','LineWidth',2)
    text(mean(xpix)+5,mean(ypix)+5,num2str(green_ids(i)),'Color','g')
 
end


title('Short Wavelength Image')
%% PLOT INTERNEURONS ON LONG WAVELENGTH IMAGE

subplot(1,2,2)
%redcells on short image 

imshow(img.long)
caxis([0 max(max(img.long))/thresholds(2)])


hold on 

red_stat=cell_stat(redcell_vect); 


for i = 1:length(red_stat)
    curstat=red_stat{i};
    xpix=double(curstat.xpix(curstat.soma_crop==1));
    ypix=double(curstat.ypix(curstat.soma_crop==1));
    
    xpix=xpix+xshift;
    ypix=ypix+yshift;

    xcoords=nan(2*range(ypix)+1,1);
    ycoords=nan(2*range(ypix)+1,1);
    ycl=unique(ypix);% y coords list 
    [ycl,~]=sort(ycl);

    for j=1:range(ypix)
        
        curx=xpix(ypix==ycl(j));
        xcoords(j)=min(curx);
        xcoords((end-1)-(j-1))=max(curx);
        ycoords(j)=ycl(j);
        ycoords((end-1)-(j-1))=ycl(j);
          
    end
    ycoords(end)=ycoords(1);
    xcoords(end)=xcoords(1);

    plot(double(xcoords),double(ycoords),'r','LineWidth',2)
    text(mean(xpix)+5,mean(ypix)+5,num2str(red_ids(i)),'Color','r')
 
end
%% PLOT PYRAMIDAL CELLS ON LONG WAVELENGTH IMAGE 

green_stat=cell_stat(redcell_vect==0); 
green_ids=cellstat_ids(redcell_vect==0);



for i = 1:length(green_stat)
    curstat=green_stat{i};
    xpix=double(curstat.xpix(curstat.soma_crop==1));
    ypix=double(curstat.ypix(curstat.soma_crop==1));
    
    xpix=xpix+xshift;
    ypix=ypix+yshift;

    xcoords=nan(2*range(ypix)+1,1);
    ycoords=nan(2*range(ypix)+1,1);
    ycl=unique(ypix);% y coords list 
    [ycl,~]=sort(ycl);
    if length(ycl)<range(xpix)
        for j=1:length(ycl)
        
            curx=xpix(ypix==ycl(j));
            xcoords(j)=min(curx);
            xcoords((end-1)-(j-1))=max(curx);
            ycoords(j)=ycl(j);
            ycoords((end-1)-(j-1))=ycl(j);    
        end
    else
        for j=1:range(ypix)
        
            curx=xpix(ypix==ycl(j));
            xcoords(j)=min(curx);
            xcoords((end-1)-(j-1))=max(curx);
            ycoords(j)=ycl(j);
            ycoords((end-1)-(j-1))=ycl(j);    
        end
    end
    ycoords(end)=ycoords(1);
    xcoords(end)=xcoords(1);

    plot(double(xcoords),double(ycoords),'g','LineWidth',2)
    text(mean(xpix)+5,mean(ypix)+5,num2str(green_ids(i)),'Color','g')
 
end


title('Long Wavelength Image')









