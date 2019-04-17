%%
clear all;
[imname, pathname] = uigetfile({'*.jpg;*.jpeg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Выберите изображение');
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
redCube = imBinary - imcomplement(imBinaryR);
blueCube = imBinary - imcomplement(imBinaryB);
greenCube = imBinary - imcomplement(imBinaryG);
blackCube = imBinary - (redCube + blueCube + greenCube);

%%
redCube = bwareafilt(logical(redCube),1);
blueCube = bwareafilt(logical(blueCube),1);
blackCube = bwareafilt(logical(blackCube),1);
%greenCube = imBinary - (redCube + blueCube + blackCube); % костыль
greenCube = bwareafilt(logical(greenCube),1);

%%
stats = regionprops(redCube, 'Centroid');
xR = stats.Centroid(1,1); 
yR = stats.Centroid(1,2);
stats = regionprops(greenCube, 'Centroid');
xG = stats.Centroid(1,1); 
yG = stats.Centroid(1,2);
stats = regionprops(blueCube, 'Centroid');
xB = stats.Centroid(1,1); 
yB = stats.Centroid(1,2);
stats = regionprops(blackCube, 'Centroid');
xK = stats.Centroid(1,1); 
yK = stats.Centroid(1,2);

%%
cubes = redCube + blueCube + greenCube + blackCube;
imshow(cubes);
hold on
plot(xR,yR,'r*')
plot(xB,yB,'b*')
plot(xG,yG,'g*')
plot(xK,yK,'k*')
hold off