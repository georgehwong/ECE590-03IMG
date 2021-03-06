function blueSegment =blueSegment(I,handles)

blueSegment=I;
cform = makecform('srgb2lab');
lab_he = applycform(blueSegment,cform);

ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
% repeat the clustering 3 times to avoid local minima
[cluster_idx cluster_center] = kmeans(ab,nColors,'distance','sqEuclidean', ...
                                      'Replicates',1);
                                  
pixel_labels = reshape(cluster_idx,nrows,ncols);


mean_cluster_value = mean(cluster_center,2);
[~, idx] = sort(mean_cluster_value);
blue_cluster_num = idx(1);

L = lab_he(:,:,1);
blue_idx = find(pixel_labels == blue_cluster_num);
L_blue = L(blue_idx);
is_light_blue = im2bw(L_blue,graythresh(L_blue));
nuclei_labels = repmat(uint8(0),[nrows ncols]);
nuclei_labels(blue_idx(is_light_blue==false)) = 1;
nuclei_labels = repmat(nuclei_labels,[1 1 3]);
blue_nuclei = blueSegment;
blue_nuclei(nuclei_labels ~= 1) = 0;


% axes(handles);

imshow(blue_nuclei);

