function [cameraCenter] = getCameraCenter(M)
    Q = M(:, 1:end-1);
    b = M(:, end);
    
    cameraCenter = [-inv(Q) * b; 1];
    cameraCenter = cameraCenter(1:3) / cameraCenter(4);
end

