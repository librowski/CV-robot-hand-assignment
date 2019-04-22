function [centroid] = getCentroid(img, ref)
    cc = bwconncomp(img);
    stats = regionprops(cc, 'Eccentricity', 'ConvexArea', 'Extrema','Centroid');
    l = zeros(4);
    j = 1;
    s = size(stats);
    s = s(1);
    for i = 1:s
        if abs(stats(i).ConvexArea/10 - ref / 10) < ref / 20
            l(j) = i;
            j = j + 1;
        end
    end
    nn = 0;
    for i = 1:16
      if l(i) > 0
          nn = nn +1;
      end
    end
    j = 1;
    for i = 1:nn
        if stats(l(i)).Eccentricity < 0.5
            centroid(j) = stats(l(i)).Centroid(1);
            centroid(j + 1) = stats(l(i)). Centroid(2);
            j = j + 2;
        end
    end
end