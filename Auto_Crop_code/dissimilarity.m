function [ D ] = dissimilarity( I, x, y, sigma)
%DISSIMILARITY Summary of this function goes here
%   Detailed explanation goes here
    h = ceil(2.5 * sigma);
    I = double(I);
    w = gauss(sigma);
    w = w * w';
    [m, n] = size(I);
    if(x(1,1) < h+1 || x(1,1) > m-h || y(1,1) < h+1 || y(1,1) > m-h)
        error('x or y is too close to the boundary');
    end
    if(x(2,1) < h+1 || x(2,1) > n-h || y(2,1) < h+1 || y(2,1) > n-h)
        error('x or y is too close to the boundary');
    end
    
    Ix = I(x(1)-h:x(1)+h, x(2)-h:x(2)+h);
    Iy = I(y(1)-h:y(1)+h, y(2)-h:y(2)+h);
    Ixy = (Ix - Iy).^2;
    D = sum(sum(Ixy.*w));
end

