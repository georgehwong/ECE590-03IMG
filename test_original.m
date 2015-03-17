close all;
clear all;
load blurImage.mat;
[H, img_deblurred] = BlindDeblurring_MichaeliIrani_v1(blurImg, 51);
