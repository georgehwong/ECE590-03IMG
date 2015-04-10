% I = imread('blurimg.png');
figure;
imshow(I);

%% edge detector, using canny.
EDGE = edge(I, 'canny', [0.1, 0.5]);
%        The Canny method finds edges by looking for local maxima of the
%        gradient of I. The gradient is calculated using the derivative of a
%        Gaussian filter. The method uses two thresholds, to detect strong
%        and weak edges, and includes the weak edges in the output only if
%        they are connected to strong edges. This method is therefore less
%        likely than the others to be "fooled" by noise, and more likely to
%        detect true weak edges.

% Corner = corner(I, 'MinimumEigenvalue');
figure;
imshow(EDGE);

%% hough transform and get peaks
[H, THETA, RHO] = hough(EDGE);
%     [H, THETA, RHO] = hough(BW) computes the SHT of the binary image BW.
%     THETA (in degrees) and RHO are the arrays of rho and theta values over 
%     which the Hough transform matrix, H, was generated.

PEAKS = houghpeaks(H, 100, 'threshold', ceil(0.5 * max(H(:))));
%     PEAKS = houghpeaks(H,NUMPEAKS) locates peaks in the Hough 
%     transform matrix, H, generated by the HOUGH function. NUMPEAKS 
%     specifies the maximum number of peaks to identify. PEAKS is 
%     a Q-by-2 matrix, where Q can range from 0 to NUMPEAKS. Q holds
%     the row and column coordinates of the peaks. If NUMPEAKS is 
%     omitted, it defaults to 1.

%     'Threshold' Nonnegative scalar.
%                 Values of H below 'Threshold' will not be considered
%                 to be peaks. Threshold can vary from 0 to Inf.
%   
%                 Default: 0.5*max(H(:))

%% Get line segment
x = THETA(PEAKS(:,2));
y = RHO(PEAKS(:,1));
LINES = houghlines(EDGE, THETA, RHO, PEAKS, 'FillGap', 5, 'MinLength', 20);
%     houghlines returns 
%     LINES structure array whose length equals the number of merged line segments found.
%     'FillGap'   Positive real scalar.
%                 When houghlines finds two line segments associated
%                 with the same Hough transform bin that are separated
%                 by less than 'FillGap' distance, houghlines merges
%                 them into a single line segment.
%  
%                 Default: 20
%  
%     'MinLength' Positive real scalar.
%                 Merged line segments shorter than 'MinLength'
%                 are discarded.
%  
%                 Default: 40


%% corner detector 
figure;
lambdaMin = smallEigenvalue(I, 3);
imagesc(lambdaMin);
% colormap gray;
lambdaMin = imcrop(lambdaMin, [9, 9, size(lambdaMin, 2)-17, size(lambdaMin, 1)-17]); 
%     imagesc(...) is the same as IMAGE(...) except the data is scaled
%     to use the full colormap.


%% Print image
figure, imshow(I), hold on
max_len = 0;
for k = 1:length(LINES)
    xy = [LINES(k).point1; LINES(k).point2];
    plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'green');

    plot(xy(1,1), xy(1,2), 'x', 'LineWidth', 2, 'Color', 'yellow');
    plot(xy(2,1), xy(2,2), 'x', 'LineWidth', 2, 'Color', 'red');

    len = norm(LINES(k).point1 - LINES(k).point2);
    if(len > max_len)
        max_len = len;
        xy_len = xy;
    end
end


%% compute weighted line segment & corner value.
% LINES.point1(2) is the x index of the original picture
% LINES.point1(1) is the y index of the original picture
for k = 1:length(LINES)
    p1 = [LINES(k).point1(2), LINES(k).point1(1)];
    p2 = [LINES(k).point2(2), LINES(k).point2(1)];
    sum1 = compute_corner_weight(lambdaMin, p1, 15);
    sum2 = compute_corner_weight(lambdaMin, p2, 15);
    weightValue(k) = (sum1+sum2) * norm(LINES(k).point1 - LINES(k).point2);
end

[~,max_segment] = max(weightValue);
xy = [LINES(max_segment).point1; LINES(max_segment).point2];
plot(xy(:,1), xy(:,2), 'LineWidth', 2, 'Color', 'blue');

% get the middle point and crop image 
middlePoint = [ceil((xy(1,1) + xy(2,1))/2) ,ceil( (xy(1,2) + xy(2,2))/2 )];
plot(middlePoint(1), middlePoint(2), '*', 'LineWidth', 2, 'Color', 'white');

middlePoint = [middlePoint(2), middlePoint(1)];
croppedImg = crop(I, middlePoint, 0.3);

figure;
imshow(croppedImg);


%% run deblurred method
%[H, img_deblurred] = BlindDeblurring_MichaeliIrani_v1(croppedImg, 51);