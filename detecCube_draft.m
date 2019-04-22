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

% %%
% redCube = imBinary - imcomplement(imBinaryR);
% blueCube = imBinary - imcomplement(imBinaryB);
% greenCube = imBinary - imcomplement(imBinaryG);
% blackCube = imBinary - (redCube + blueCube + greenCube);

%%
% redCube = bwareafilt(logical(redCube),1);
% blueCube = bwareafilt(logical(blueCube),1);
% blackCube = bwareafilt(logical(blackCube),1);
% %greenCube = imBinary - (redCube + blueCube + blackCube); % костыль
% greenCube = bwareafilt(logical(greenCube),1);

%%
% stats = regionprops(redCube, 'Centroid');
% xR = stats.Centroid(1,1); 
% yR = stats.Centroid(1,2);
% stats = regionprops(greenCube, 'Centroid');
% xG = stats.Centroid(1,1); 
% yG = stats.Centroid(1,2);
% stats = regionprops(blueCube, 'Centroid');
% xB = stats.Centroid(1,1); 
% yB = stats.Centroid(1,2);
% stats = regionprops(blackCube, 'Centroid');
% xK = stats.Centroid(1,1); 
% yK = stats.Centroid(1,2);
% 
% %%
% cubes = redCube + blueCube + greenCube + blackCube;
% imshow(cubes);
% hold on
% plot(xR,yR,'r*')
% plot(xB,yB,'b*')
% plot(xG,yG,'g*')
% plot(xK,yK,'k*')
% hold off

%%
% cube = imread('black.jpg');
% bw = rgb2gray(image);
% bwcube = rgb2gray(cube);
% boxPoints = detectSURFFeatures(bwcube);
% scenePoints = detectSURFFeatures(bw);
% 
% figure;
% imshow(bwcube);
% title('10 Strongest Feature Points from Cube Image');
% hold on;
% plot(selectStrongest(boxPoints, 10));

%%
% [boxFeatures, boxPoints] = extractFeatures(bwcube, boxPoints);
% [sceneFeatures, scenePoints] = extractFeatures(bw, scenePoints);
% 
% boxPairs = matchFeatures(boxFeatures, sceneFeatures);
% matchedBoxPoints = boxPoints(boxPairs(:, 1), :);
% matchedScenePoints = scenePoints(boxPairs(:, 2), :);
% figure;
% showMatchedFeatures(bwcube, bw, matchedBoxPoints, ...
%     matchedScenePoints, 'montage');
% title('Putatively Matched Points (Including Outliers)');

%%
green = imBinaryG - (imBinaryB + imBinaryR);
green(green < 0) = 0;
green = logical(green);
green = bwareafilt(green, 3);
hull = bwconvhull(green);
ch = bwconncomp(hull);
stath = regionprops(ch, 'ConvexArea');
cc = bwconncomp(imBinary);
stats = regionprops(cc, 'Eccentricity', 'ConvexArea', 'Extrema','Centroid');
%%
l = zeros(4);
j = 1;
s = size(stats);
s = s(1);
for i = 1:s
    if abs(stats(i).ConvexArea/10 - stath(1).ConvexArea / 10) < stath(1).ConvexArea / 20
        l(j) = i;
        j = j + 1;
    end
end
 %%
% 
% n = 3;
% s = size(stats(l(n)).Extrema);
% s = s(1);
% for i = 1:s
%     xx(i) = stats(l(n)).Extrema(i);
% end
% for i = 1:s
%     yy(i) = stats(l(n)).Extrema(i+s);
% end
% figure;
% imshow(imBinary);
% hold on
% for i = 1:s
%     plot(xx(i),yy(i),'r*');
% end
% hold off


%%
nn = 0;
for i = 1:16
    if l(i) > 0
        nn = nn +1;
    end
end
%%
j = 1;
for i = 1:nn
    if stats(l(i)).Eccentricity < 0.5
        centr(j) = stats(l(i)).Centroid(1);
        centr(j + 1) = stats(l(i)). Centroid(2);
        j = j + 2;
    end
end

%%
% for i = 1:3
%     s = size(cbs(i).PixelIdxList);
%     for j = 1:s
%         xcbs(i,j) = fix(cbs(i).PixelIdxList(j) ./ dims(1));
%         ycbs(i,j) = rem(cbs(i).PixelIdxList(j), dims(1));
%     end
% end

%%
figure 
imshow(image)
hold on
for i = 1:2:5
    plot(centr(i),centr(i+1),'r*');
end
hold off