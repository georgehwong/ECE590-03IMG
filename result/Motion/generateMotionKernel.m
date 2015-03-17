% K is the Kernel

M = fspecial('motion',15, 0);
figure


H = zeros(1,51);
H(19:33) = M;

K = zeros(51,51);
K(26,:) = H;

blurImg = uint8(conv2(double(img), double(K), 'valid'));
imshow(blurImg);
