

clear all;
img2 = imread('6_1_blurred.png');
[H2, img_deblurred] = BlindDeblurringAllLevels(img2, 51);
save('kernel_6_1_blurred.mat','H2');


clear all;
img3 = imread('10_1_blurred.png');
[H3, img_deblurred] = BlindDeblurringAllLevels(img3, 51);
save('kernel_10_1_blurred.mat','H3');


clear all;
img4 = imread('39_7_blurred.png');
[H4, img_deblurred] = BlindDeblurringAllLevels(img4, 51);
save('kernel_39_7_blurred.mat','H4');

