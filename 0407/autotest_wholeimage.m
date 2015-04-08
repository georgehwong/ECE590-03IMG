clear all;
img1 = imread('1_7_blurred.png');
[H1, img_deblurred] = BlindDeblurringAllLevels(img1, 51);
save('kernel_1_7_blurred.mat','H1');
patchSize = 8;
noiseSD = 0.01;
I = imread('img1_groundtruth_img.png');
I = double(I)/255;
K = rot90(H,2);

% load GMM model
load GSModel_8x8_200_2M_noDC_zeromean.mat

% uncomment this line if you want the total cost calculated
% LogLFunc = @(Z) GMMLogL(Z,GS); 

% initialize prior function handle
excludeList = [];
prior = @(Z,patchSize,noiseSD,imsize) aprxMAPGMM(Z,patchSize,noiseSD,imsize,GS,excludeList);

% comment this line if you want the total cost calculated
LogLFunc = [];

% deblur
tic
[cleanI,psnr,~] = EPLLhalfQuadraticSplitDeblur(double(img1)/255,64/noiseSD^2,K,patchSize,50*[1 2 4 8 16 32 64],1,prior,I,LogLFunc);
toc
save('deblurred_1_7_blurred.mat','cleanI');

clear all;
img2 = imread('6_1_blurred.png');
[H2, img_deblurred] = BlindDeblurringAllLevels(img2, 51);
save('kernel_6_1_blurred.mat','H2');
patchSize = 8;
noiseSD = 0.01;
I = imread('img6_groundtruth_img.png');
I = double(I)/255;
K = rot90(H,2);

% load GMM model
load GSModel_8x8_200_2M_noDC_zeromean.mat

% uncomment this line if you want the total cost calculated
% LogLFunc = @(Z) GMMLogL(Z,GS); 

% initialize prior function handle
excludeList = [];
prior = @(Z,patchSize,noiseSD,imsize) aprxMAPGMM(Z,patchSize,noiseSD,imsize,GS,excludeList);

% comment this line if you want the total cost calculated
LogLFunc = [];

% deblur
tic
[cleanI,psnr,~] = EPLLhalfQuadraticSplitDeblur(double(img2)/255,64/noiseSD^2,K,patchSize,50*[1 2 4 8 16 32 64],1,prior,I,LogLFunc);
toc
save('deblurred_6_1_blurred.mat','cleanI');

clear all;
img3 = imread('10_1_blurred.png');
[H3, img_deblurred] = BlindDeblurringAllLevels(img3, 51);
save('kernel_10_1_blurred.mat','H3');
patchSize = 8;
noiseSD = 0.01;
I = imread('img10_groundtruth_img.png');
I = double(I)/255;
K = rot90(H,2);

% load GMM model
load GSModel_8x8_200_2M_noDC_zeromean.mat

% uncomment this line if you want the total cost calculated
% LogLFunc = @(Z) GMMLogL(Z,GS); 

% initialize prior function handle
excludeList = [];
prior = @(Z,patchSize,noiseSD,imsize) aprxMAPGMM(Z,patchSize,noiseSD,imsize,GS,excludeList);

% comment this line if you want the total cost calculated
LogLFunc = [];

% deblur
tic
[cleanI,psnr,~] = EPLLhalfQuadraticSplitDeblur(double(img3)/255,64/noiseSD^2,K,patchSize,50*[1 2 4 8 16 32 64],1,prior,I,LogLFunc);
toc
save('deblurred_10_1_blurred.mat','cleanI');

clear all;
img4 = imread('39_7_blurred.png');
[H4, img_deblurred] = BlindDeblurringAllLevels(img4, 51);
save('kernel_39_7_blurred.mat','H4');

patchSize = 8;
noiseSD = 0.01;
I = imread('img39_groundtruth_img.png');
I = double(I)/255;
K = rot90(H,2);

% load GMM model
load GSModel_8x8_200_2M_noDC_zeromean.mat

% uncomment this line if you want the total cost calculated
% LogLFunc = @(Z) GMMLogL(Z,GS); 

% initialize prior function handle
excludeList = [];
prior = @(Z,patchSize,noiseSD,imsize) aprxMAPGMM(Z,patchSize,noiseSD,imsize,GS,excludeList);

% comment this line if you want the total cost calculated
LogLFunc = [];

% deblur
tic
[cleanI,psnr,~] = EPLLhalfQuadraticSplitDeblur(double(img4)/255,64/noiseSD^2,K,patchSize,50*[1 2 4 8 16 32 64],1,prior,I,LogLFunc);
toc
save('deblurred_39_7_blurred.mat','cleanI');