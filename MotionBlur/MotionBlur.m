function [D]=MotionBlur(I)
%% Load image, convert to gray scale and show
%tic;

%I=imread('20.jpg');
figure(1); 
imshow(I);
title('Original Image')

%noise = imnoise(I,'salt & pepper');
%imshow(noise);
%title('Original Image')
%I=noise;

% if isrgb(I);
    gs=rgb2gray(I);
% else
%     gs=I;
% end;

gs=im2double(gs);
figure(2);
imshow(gs);
title('Gray Scale Image');

%% Check if image is blurred (any kind of blur)

%% Create edge map

E1=edge(gs, 'sobel', 0.05); % trashold to test
E2=edge(gs, 'canny',0.07); % trashold to test
E=E1&E2;
figure(3);
imshow(E);
title('Edge Map');

%% Find direction matrix
[Ex,Ey]=size(E);
xParts=6;
yParts=6;
D=zeros(xParts,yParts);
partSizeX=floor(Ex/xParts);
partSizeY=floor(Ey/yParts);
xRange=partSizeX;
yRange=partSizeY;

for x=1:xParts;
    for y=1:yParts;
        if x-1*partSizeX+partSizeX>Ex;
            xRange=Ex-x-1*partSizeX;
        end;
        if y-1*partSizeY+partSizeY>Ey;
            yRange=Ey-y-1*partSizeY;
        end;
       % EdgePart=Edges((x-1)*partSizeX+1:(x-1)*partSizeX+xRange,(y-1)*partSizeY+1:(y-1)*partSizeY+yRange);
        %if isBlur(EdgePart)<5
            D(x,y)=...
                direction(E((x-1)*partSizeX+1:(x-1)*partSizeX+xRange,(y-1)*partSizeY+1:(y-1)*partSizeY+yRange));
        %else
         %   D(x,y)=-1;
        %end;
    end;
end;

%BSF=fspecial('motion',8,D(1,1));
%RES=AviDeBlur(gs,BSF);
%figure;
%imshow(RES);

%% Show Results

figure(4);
imshow(gs);
axis on;
hold on;
[rows, cols]=size(gs);
nrows=rows/xParts;
ncols=cols/yParts;
y=1:cols;
z=1:rows;
o=ones(1,cols);
o2=ones(rows,1);
hold on;
for k=1:xParts
    plot(y,k*nrows*o,'-g');
    plot(k*ncols*o2,z,'-g');
end
hold on;

centerX=zeros(xParts*yParts);
centerY=zeros(xParts*yParts);
qx=zeros(xParts*yParts);
qy=zeros(xParts*yParts);
g=1;
for i=1:xParts
    for j=1:yParts
        if D(i,j)~=-1
            centerX(g)= floor(i*rows/xParts-rows/(xParts*2));
            centerY(g)= floor(j*cols/xParts-cols/(xParts*2));
            qx(g)=cos(degtorad(180-D(i,j)));
            qy(g)=sin(degtorad(180-D(i,j)));
        end
            g=g+1;
    end;
end;
quiver(centerY,centerX,qx,qy,0.01*partSizeX);
hold on;

%toc

end
