function chemin_generateur_simple(varargin)
adresse = 'E:\Onedrive\Documents\Lonaparte-PC\Codes\PE\Mission_3_chemin\';
if nargin>0
    adresse = varargin;
end
data = importdata(strcat(adresse, 'coordonate.txt'));
Xchemin = data(:, 1);
Ychemin = data(:, 2);
angle = 0;
[n, m] = size(data);
f=fopen(strcat(adresse, 'commande_par_generateur.c'), 'w+');
fprintf(f, '#include "mouvement_droit.c"\n');
fprintf(f, '#include "pointturn.c"\n\n');
fprintf(f, 'task main()\n{\n');
x1 = Xchemin(1);
y1 = Ychemin(1);
alpha1 = angle;
for i = 2:n
    x2 = Xchemin(i);
    y2 = Ychemin(i);
    if y2 > y1
        alpha2 = atan((x2 - x1)/(y2 - y1));
    elseif (y2 < y1) && (x2 < x1)
        alpha2 = atan((x2 - x1)/(y2 - y1)) - pi;
    elseif (y2 < y1) && (x2 >= x1)
        alpha2 = pi - atan((x2 - x1)/(y1 - y2));
    elseif (y2 == y1) && (x2 < x1)
        alpha2 = -pi/2;
    else 
        alpha2 = pi/2;
    end
    distance = sqrt((y2 - y1)^2 + (x2 - x1)^2);
    deg = alpha2 - alpha1;
    if deg < 0
        fprintf(f,'\tturnLeftDeg(%d,20);\n', ceil(-deg*180/pi));
    else 
        fprintf(f,'\tturnRightDeg(%d,20);\n', floor(deg*180/pi));
    end
    fprintf(f,'\tavance_nulle(%g);\n', distance);
    x1 = x2;
    y1 = y2;
    alpha1 = alpha2;
end

fprintf(f, '}');
fclose(f);
