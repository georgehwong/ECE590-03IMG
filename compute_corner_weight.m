function summation = compute_corner_weight( img, point, patch_size )
%COMPUTE_CORNER_WEIGHT Summary of this function goes here
%   Detailed explanation goes here
    if( mod(patch_size, 2) ~= 1)
        patch_size = patch_size + 1;
    end

    if(point(1) <= ceil(patch_size/2))
        xmin = 1;
    else
        xmin = point(1) - ceil(patch_size/2); 
    end
    
    if(point(1) >= size(img, 1) - ceil(patch_size/2))
        xmax = size(img, 1);
    else 
        xmax = point(1) + ceil(patch_size/2);
    end
    
    if(point(2) <= ceil(patch_size/2))
        ymin = 1;
    else 
        ymin = point(2) - ceil(patch_size/2);
    end
    
    if(point(2) >= size(img, 2) - ceil(patch_size/2))
        ymax = size(img, 2);
    else
        ymax = point(2) + ceil(patch_size/2);
    end
    
    summation = sum(sum(img(xmin:xmax, ymin:ymax)));
  
end

