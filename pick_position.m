%%
% grabImage = 'CMD_GRAB_IMAGE';
% 
% image = RV3SB_client(grabImage);
clear all;
[imname, pathname] = uigetfile({'*.jpg;*.jpeg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Выберите изображение');
path = fullfile(pathname,imname);
image = imread(path);


figure
imshow(image)
[x,y] = getpts;
XY(:,1) = x;
XY(:,2) = y;
save('xy.mat', 'XY');

%%
% clear all;
% load('xy.mat');