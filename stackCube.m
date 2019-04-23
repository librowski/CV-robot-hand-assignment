function stackCube(cubeXY, towerXY, towerHeight)
    %% ROBOT HAND COMMANDS
    gripOpen = 'CMD_GRIP_OPEN';
    gripClose = 'CMD_GRIP_CLOSE';
    moveTo = 'CMD_MOVETO';

    %% GETING POINT COORDINATES FOR ROBOT WITH FIXED ROTATION
    robotPoint = @(x, y, z) [ x y z 180 0 163];
    
    %% DANCE
    % RVS3B_client(gripOpen);
    disp("I open the grip");
    % RVS3B_client(moveTo, robotPoint(cubeXY(1), cubeXY(2), 35);
    disp("I move to the point: ");
    disp(robotPoint(cubeXY(1), cubeXY(2), 35));
    % RVS3B_client(gripClose);
    disp("I close the grip");
    % RVS3B_client(moveTo, robotPoint(towerXY(1), towerXY(2), towerHeight);
    disp("I move to the point: ")
    disp(robotPoint(towerXY(1), towerXY(2), towerHeight));
end


