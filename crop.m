function img = crop( img, point, percentage)
%CROP Summary of this function goes here
%   Detailed explanation goes here
%   我他妈改一下备注
xsize = ceil( size(img, 1) * percentage / 2);
ysize = ceil( size(img, 2) * percentage / 2);
    
if(point(1) <= xsize)
    xmin = 1;
else 
    xmin = point(1) - xsize;
end

if(point(1) >= size(img, 1) - xsize)
    xmax = size(img, 1);
else 
    xmax = point(1) + xsize;
end

if(point(2) <= ysize)
    ymin = 1;
else 
    ymin = point(2) - ysize;
end

if(point(2) >= size(img, 2) - ysize)
    ymax = size(img, 2);
else
    ymax = point(2) + ysize;
end

img = img((xmin:xmax), (ymin:ymax));

end

