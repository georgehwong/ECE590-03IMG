close all;
clear all;
load img62_blur_defocus_Gaussian3.mat;
[H, img_deblurred] = BlindDeblurring_MichaeliIrani_v1(noiseImg, 51);
