function [coordinates] = getPointCoordinates(p1, p2, Z)
    v = p2 - p1;
    
    t = (Z - p1(3)) / v(3);
    x = p1(1) + t * v(1);
    y = p1(2) + t * v(2);
    
    coordinates = [x y Z];
end

