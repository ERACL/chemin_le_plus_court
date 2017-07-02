function [Xres, Yres] = propre(X, Y)
% Ce function va calculer tout les points propres.
try
    k = myConvhull(X,Y);                     
    Xres = fliplr(X(k));
    Yres = fliplr(Y(k));
catch
    Xres = [];
    Yres = [];
end