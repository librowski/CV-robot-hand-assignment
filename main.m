clear all;

% PREDEFINED 3D POINTS COORDINATES %
points3D = [
    [380 25 50];
    [430 -25 0];
    [680 75 50];
    [630 25 0];
    [430 -175 50];
    [480 225 50];
    [580 -125 50];
    [630 -175 50];
];

% GETTING 2D POSITIONS FROM IMAGE %
[imname, pathname] = uigetfile({'*.jpg;*.jpeg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Choose an image');
path = fullfile(pathname,imname);
image = imread(path);

figure
imshow(image)
[x,y] = getpts;
points2D(:,1) = x;
points2D(:,2) = y;

M = calibrateCamera(points2D, points3D);

C = getCameraCenter(M);



