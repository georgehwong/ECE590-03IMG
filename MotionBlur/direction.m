function [D]=direction(E)
%% Hough transform to detect lines
H=hough(E);
HH=H;
HH=mat2gray(HH);
%figure;
%imshow(imadjust(HH));
%colormap hot;
%axis on;

[Hx,Hy]=size(HH);
for i=1:Hx;
    for j=1:Hy;
       if HH(i,j)<0.6
           HH(i,j)=0;
       else
           HH(i,j)=H(i,j);
       end;
    end;
end;

%figure;
%imshow(HH);
%colormap(hot);
%axis on;

%%
[a,b]=find(HH>0);
sizeB=size(b);
maxVal=0;
treshAngle=8;
Teta=0;
for i=1:sizeB;
    if HH(a(i),b(i))>maxVal;
        maxVal=HH(a(i),b(i));
        Teta = b(i);
    end;
end;

good=0; bad=0;
for i=1:sizeB;
    if abs(b(i)-Teta)<treshAngle || abs(b(i)-Teta)>180-treshAngle
        good = good+HH(a(i),b(i));
    else
        bad = bad+HH(a(i),b(i));
    end;
end;

[s,ss]=size(E);
if bad/(bad+good)<0.3 && good/(s*ss)>0.005;
    D = 180-Teta;
else
    D = -1;
end;



end