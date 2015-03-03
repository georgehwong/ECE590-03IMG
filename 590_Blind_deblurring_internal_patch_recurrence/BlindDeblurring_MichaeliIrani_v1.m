function [H, img_deblurred] = BlindDeblurring_MichaeliIrani_v1(img, KernelSize)

%  [H, img_deblurred] = 
%   BlindDeblurring_MichaeliIrani_v1(img, KernelSize)
%  returns the blur kernel H associated with the blur in
%  the image img, as well as a deblurred version, 
%  img_deblurred, of img.
%
%  KernelSize determines the width of the (square) kernel H.
%  If KernelSize is even, it is modified to be odd.
%  
%  If img is a color image, it is converted to grayscale
%  values in the range [0,255].
%
%  The kernel H is a correlation kernel (not a
%  convolution kernel). Namely, it is assumed that img
%  is roughly given by filter2(H, img_deblurred) and not by
%  conv2(img_deblurred, H, 'same').
%  To convert H into a convolution kernel, use:
%       H = rot90(H,2)
%
%  This code is based on the paper:
%       Tomer Michaeli and Michal Irani,
%       "Blind deblurring using internal patch recurrence"
%       ECCV 2014
%
%  This Matlab code is distributed only for academic
%  research purposes.
%  For other purposes, please contact Tomer Michaeli.
%
%  Version 1.0, September 2014.



% Make KernelSize odd
KernelSize = floor(KernelSize/2)*2+1;
if max(img(:))<=1
    img = double(img) * 255;
end

% Convert color images to gray-scale (doubles in the range [0,255])
if size(img,3) == 3
    img = rgb2gray(uint8(img));
end
img = double(img);

% Perform blind deblurring
 [H, img_deblurred] = BlindDeblurringAllLevels(img, KernelSize);