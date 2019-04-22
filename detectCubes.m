function [centroid] = detectCubes(image)
%%
level = graythresh(image);
bwl = im2bw(image, (level ^ 1.5) * 2.5);
bwl = bwareafilt(bwl,1);
[rows, columns] = find(bwl);
row1 = min(rows);
row2 = max(rows);
col1 = min(columns);
col2 = max(columns);
im = image(row1:row2, col1:col2,:);
%%
im = im2double(im);
[r c p] = size(im);
imR = squeeze(im(:,:,1));
imG = squeeze(im(:,:,2));
imB = squeeze(im(:,:,3));

imBinaryR = im2bw(imR,(level ^ 1.76) * 1.66);
imBinaryG = im2bw(imG,(level ^ 1.76) * 1.66);
imBinaryB = im2bw(imB,(level ^ 1.76) * 1.66);

imBinary = imcomplement(imBinaryR&imBinaryG&imBinaryB);
%%
cubes = bwpropfilt(imBinary,'Eccentricity',[0 0.7]);

cubes = bwareafilt(cubes, 4);
%imshow(cubes);
%%
red = imBinaryR - (imBinaryG + imBinaryB);
red(red < 0) = 0;
red = logical(red);
red = bwareafilt(red, 1);
red = bwconvhull(red);

%%
blue = imBinaryB - (imBinaryG + imBinaryR);
blue(blue < 0) = 0;
blue = logical(blue);
blue = bwareafilt(blue,1);
blue = bwconvhull(blue);

%%
green = imBinaryG - (imBinaryR + imBinaryB);
green(green < 0) = 0;
green = logical(green);
green = bwareafilt(green,1);
green = bwconvhull(green);

%%
black = cubes - (red + green + blue);
black(black < 0) = 0;
black = logical(black);
black = bwareafilt(black,1);

%%
green = cubes - (black + red + blue);
green(green < 0) = 0;
green = logical(green);
green = bwareafilt(green,1);

blue = cubes - (black + red + green);
blue(blue < 0) = 0;
blue = logical(blue);
blue = bwareafilt(blue,1);
%%
cc = bwconncomp(red);
stats = regionprops(cc, 'Centroid');
centrR = stats(1).Centroid;
centrR(1) = centrR(1)+col1;
centrR(2) = centrR(2)+row1;

cc = bwconncomp(blue);
stats = regionprops(cc, 'Centroid');
centrB = stats(1).Centroid;
centrB(1) = centrB(1)+col1;
centrB(2) = centrB(2)+row1;

cc = bwconncomp(green);
stats = regionprops(cc, 'Centroid');
centrG = stats(1).Centroid;
centrG(1) = centrG(1)+col1;
centrG(2) = centrG(2)+row1;

cc = bwconncomp(black);
stats = regionprops(cc, 'Centroid');
centrK = stats(1).Centroid;
centrK(1) = centrK(1)+col1;
centrK(2) = centrK(2)+row1;

%%
centroid(1,1) = centrR(1);
centroid(1,2) = centrR(2);
centroid(2,1) = centrG(1);
centroid(2,2) = centrG(2);
centroid(3,1) = centrB(1);
centroid(3,2) = centrB(2);
centroid(4,1) = centrK(1);
centroid(4,2) = centrK(2);
