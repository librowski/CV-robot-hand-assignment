%%
clear all;
[imname, pathname] = uigetfile({'*.jpg;*.jpeg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Choose image');
path = fullfile(pathname,imname);
image = imread(path);

%%
im = im2double(image);
[r c p] = size(im);
imR = squeeze(im(:,:,1));
imG = squeeze(im(:,:,2));
imB = squeeze(im(:,:,3));

imBinaryR = im2bw(imR,0.25);
imBinaryG = im2bw(imG,0.25);
imBinaryB = im2bw(imB,0.25);

imBinary = imcomplement(imBinaryR&imBinaryG&imBinaryB);
%%
% green = imBinaryG - (imBinaryB + imBinaryR);
% green(green < 0) = 0;
% green = logical(green);
% green = bwareafilt(green, 3);
% hull = bwconvhull(green);
% ch = bwconncomp(hull);
% stath = regionprops(ch, 'ConvexArea');
% cc = bwconncomp(imBinary);
% stats = regionprops(cc, 'Eccentricity', 'ConvexArea', 'Extrema','Centroid');

%%
cubes = bwareafilt(imBinary, [70000 120000]);
testG = bwareafilt(cubes & imBinaryG, 1);
testG = bwconvhull(testG);
cc = bwconncomp(testG);
stats = regionprops(cc, 'Centroid');
centrG = stats(1).Centroid;

testB = bwareafilt(cubes & imBinaryB, 1);
testB = bwconvhull(testB);
cc = bwconncomp(testB);
stats = regionprops(cc, 'Centroid');
centrB = stats(1).Centroid;
%%
testK = cubes - (testB + testG);
testK(testK < 0) = 0;
testK = logical(testK);
testK = bwareafilt(testK, 1);
testK = bwconvhull(testK);
cc = bwconncomp(testK);
stats = regionprops(cc, 'Centroid');
centrK = stats(1).Centroid;
%%
testR = imBinaryR - (imBinaryB + imBinaryG);
testR(testR < 0) = 0;
testR = logical(testR);
testR = bwareafilt(testR,[70000 120000]);
testR = bwconvhull(testR);
cc = bwconncomp(testR);
stats = regionprops(cc, 'Centroid');
centrR = stats(1).Centroid;
%%
figure
imshow(image)
hold on
plot(centrG(1),centrG(2),'g*')
plot(centrB(1),centrB(2),'b*')
plot(centrK(1),centrK(2),'k*')
plot(centrR(1),centrR(2),'r*')
hold off

%%
