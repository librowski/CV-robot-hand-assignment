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

M = calibrateCamera(points2D, points3D);

C = getCameraCenter(M);