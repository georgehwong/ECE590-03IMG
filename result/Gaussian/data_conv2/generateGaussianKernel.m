G = fspecial('Gaussian',[51 51],3);

figure();
blurImg = uint8(conv2(double(img), double(G), 'valid'));
imshow(blurImg);
