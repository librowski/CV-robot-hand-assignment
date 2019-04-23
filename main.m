clear all;

%% PREDEFINED 3D POINTS COORDINATES %
% points3D = [
%     [380 25 50];
%     [430 -25 0];
%     [680 75 50];
%     [630 25 0];
%     [430 -175 50];
%     [480 225 50];
%     [580 -125 50];
%     [630 -175 50];
% ];

points3D = [
    [482 -180 50];
    [432 -130 0];
    [683 -20 50];
    [633 30 0];
    [632 -232 50];
    [582 -182 0];
    [432 20 50];
    [382 70 0];
];

CUBE_OPTIONS = ["Red"; "Blue"; "Green"; "Black"];

TOWER_HEIGHT = 80; % FIRST CUBE HEIGHT (50) + MIDDLE OF NEXT CUBE (25) + SOME SPACE (5)

grabImage = 'CMD_GRAB_IMAGE';
stopRobot = 'CMD_STOP';

%% GETTING 2D POSITIONS FROM IMAGE %
[imname, pathname] = uigetfile({'*.jpg;*.jpeg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Choose an image');
path = fullfile(pathname,imname);
image = imread(path);

figure
imshow(image)
[x,y] = getpts;
points2D(:, 1) = x;
points2D(:, 2) = y;

%% TAKE THE PROJECTION MATRIX AND CAMERA CENTER LOCATION %

M = calibrateCamera(points2D, points3D);

C = getCameraCenter(M);

%% TAKE THE PSEUDO INVERSE MATRIX %

M_inv = pinv(M);

%% LOCATING CUBES

[imname, pathname] = uigetfile({'*.jpg;*.jpeg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Choose an image');
path = fullfile(pathname,imname);
image2 = imread(path);

image2 = RV3SB_client(grabImage);

cb = detectCubes(image2);
cb(1:end, 3) = 1;

for i=1:4
    cp_raw(i,:) = (M_inv * cb(i,:)')';
    cube_positions_values(i,:) = [cp_raw(i,1) cp_raw(i,2) cp_raw(i,3)] / cp_raw(i,4);
    cube_positions_values(i,:) = getPointCoordinates(C, cube_positions_values(i, :)', 25);
end

CUBE_POSITIONS = containers.Map();
CUBE_POSITIONS('Red') = cube_positions_values(1,1:3);
CUBE_POSITIONS('Green') = cube_positions_values(2,1:3);
CUBE_POSITIONS('Blue') = cube_positions_values(3,1:3);
CUBE_POSITIONS('Black') = cube_positions_values(4,1:3);

%% SELECTING THE FIRST CUBE
[choice, CUBE_OPTIONS] = chooseCube(CUBE_OPTIONS);
coords = CUBE_POSITIONS(choice);
towerXY = coords(1:2);

%% ITERATING OVER 3 REMAINING CUBES

for i=1:3
    [choice, CUBE_OPTIONS] = chooseCube(CUBE_OPTIONS);
    coords = CUBE_POSITIONS(choice);
    cubeXY = coords(1:2);
    stackCube(cubeXY, towerXY, TOWER_HEIGHT);
    TOWER_HEIGHT = TOWER_HEIGHT + 50;
end

% RV3SB_client(stopRobot);
