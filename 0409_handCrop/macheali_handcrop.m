clc all;
clear all;
blurImg = imread('blurImg.png');
cropImg = blurImg(165:280,1:290)
resImg = blurImg;
resImg(165:280,1:290) = 0;
[H_crop, img_deblurred_crop] = BlindDeblurringAllLevels(cropImg, 51);
[H_rest, img_deblurred1_rest] = BlindDeblurringAllLevels(resImg, 51);

save('kernel_handCrop_blurred.mat','H_crop');
save('kernel_handCrop_blurred.mat','H_rest');

save('img_deblurred_handCrop.mat','img_deblurred_crop');
save('img_deblurred_handCrop.mat','img_deblurred_rest');
