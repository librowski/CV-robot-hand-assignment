clear all;
[imname, pathname] = uigetfile({'*.jpg;*.jpeg;*.tif;*.png;*.gif','All Image Files';...
          '*.*','All Files' },'Choose image');
path = fullfile(pathname,imname);
image = imread(path);
centroids = detectCubes(image);

figure
imshow(image)
hold on
plot(centroids(1,1),centroids(1,2),'r*')
plot(centroids(2,1),centroids(2,2),'g*')
plot(centroids(3,1),centroids(3,2),'b*')
plot(centroids(4,1),centroids(4,2),'k*')
hold off