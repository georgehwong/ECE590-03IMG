clear;
patchSize = 8;

img = imread('img62_groundtruth_img.png');
I = double(img)/255;

% load blurring kernel (you can download the kernels from Dilip Krishnan's
% website
% load kernels.mat
% K = kernel1;
% K = fspecial('motion',10,45);
K = fspecial('gaussian',[51 51],3);
noiseSD = 0.01;
patchSize = 8;


% convolve with kernel and add noise
ks = floor((size(K, 1) - 1)/2);
yorig = I;
y = conv2(yorig, K, 'valid');
y = y + noiseSD*randn(size(y));
y = double(uint8(y .* 255))./255;

% code excerpt taken from Krishnan et al.

% edgetaper to better handle circular boundary conditions
y = padarray(y, [1 1]*ks, 'replicate', 'both');
for a=1:4
  y = edgetaper(y, K);
end

noiseImg = y;


% output result
figure(2);
imshow(noiseImg); title('Corrupted Image');