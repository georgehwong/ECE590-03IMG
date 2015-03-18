close all;
clear all;
load img62_blur_kernel1.mat;
[H, img_deblurred] = BlindDeblurring_MichaeliIrani_v1(noiseI, 51);
imagesc(H);
colormap(gray);
