function [M] = calibrateCamera(points2d, points3d)
    
    n = length(points2d);
    A = zeros(n, 12);

    % CREATING A MATRIX %
    for i = 1:n
        idx = i * 2 - 1; 
        x2D = points2d(i, 1);
        y2D = points2d(i, 2);
        
        A(idx,:) = [points3d(i, :) [1 0 0 0 0] -x2D * points3d(i, :) -x2D];
        A(idx+1,:) = [[0 0 0 0] points3d(i, :) (1) -y2D * points3d(i, :) -y2D];
    end
    
    % GETING V TRANSPOSED FROM SINGULAR VALUE DECOMPOSITION %
    [~, ~, V_transpose] = svd(A);
    
    m = V_transpose(:, 12);
    
    M = transpose(reshape(m, 4, 3));
end