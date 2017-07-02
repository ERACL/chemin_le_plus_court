function chemin_generateur(varargin)
% function chemin_generateur()
% function chemin_generateur(Adresse)
%
%   Ce function est le main function du cet objet.
%   Il va lecturer les points dans le fichier "data_initial.txt", calculer
%       tout les points propre, et les ecrire dans le fichier "result.txt".
%   L'adresse par default est de 'E:\Onedrive\Documents\Lonaparte-PC\Codes\
%       PE\Mission_3_chemin'
%   On peut changer l'adresse avec la parametre 'Adresse'
%   Quand on utilise la parametre 'Adresse', on doit adde '\' pour windows 
%       ou '/' pour Linux et Mac.
%   Le code du robot C est genere dans le fiche 'commande_par_generateur.c'.
%
%   La formule du data_initial.txt:
%   	X coordonate de 1*ere* obstacle  
%	Y coordonate de 1*ere* obstacle  
%	X coordonate de 2*eme* obstacle  
%	Y coordonate de 2*eme* obstacle  
% 	...   
%	Y coordonate de N*eme* obstacle  
%	X coordonate de point initial   Y coordonate de point initial  
%	X coordonate de point finale    Y coordonate de point finale  
%	longueur propre du robot    angle initiale du robot, comme l'horloge
%
%   La formule du result.txt:
%	X coordonate du chemin
%	Y coordonate du chemin
% 
%   La formule du commande_par_genereteur.c:
%	On peut copier et coller les codes dans l'IDE du robot C directement.
%
%   L'unite de mesure:
%       Longueur: mm
%       Degree: rad
adresse = 'E:\Onedrive\Documents\Lonaparte-PC\Codes\PE\Mission_3_chemin\';
if nargin>0
    adresse = varargin;
end
fr=importdata(strcat(adresse, 'data_initial.txt'));
data=fr;
[m, n]=size(data);
l = data(m,1);
angle = data(m,2);
obstacle = data(2:(m-3),:);
Xini=data(m-2,[1,2]);
Xfin=data(m-1,[1,2]);
Xtemp = [];
Ytemp = [];
for i = 1:2:(m-3)
    X = data(i, :);
    Y = data(i+1, :);
    if interieur(X, Y, Xini, Xfin, l)==1
        Xtemp = [Xtemp, X];
        Ytemp = [Ytemp, Y];
    end
end
[X, Y] = propre(Xtemp, Ytemp);
X_Y = unique([X',Y'],'rows');
if size(X_Y) == [0, 0]
    fprintf('Erreur pour les points. Verifier si on a besoin de calculer.\n');
    return
end
X = X_Y(:,1)';
Y = X_Y(:,2)';
[m, n]=size(X);
Xc = sum(X)/n;
Yc = sum(Y)/n;
for i =1:n
    for j = i:n
        if (X(i)-Xc)*(Y(j)-Yc)<(X(j)-Xc)*(Y(i)-Yc)
            a = X(i);
            b = Y(i);
            X(i) = X(j);
            Y(i) = Y(j);
            X(j) = a;
            Y(j) = b;
        end
    end
end
%plot(X,Y)
[Xres, Yres]=chemin(X, Y, l);
[Xchemin,Ychemin] = cheminLePlusCourt(Xres,Yres,Xini,Xfin,l,obstacle);
Xchemin = [Xini(1), Xchemin, Xfin(1)];
Ychemin = [Xini(2), Ychemin, Xfin(2)];
f=fopen(strcat(adresse, 'result.txt'),'w+');
[m, n]=size(Xchemin);
%fprintf(f,'%g\t%g\n%g\t%g\n',Xini(1),Xini(2),Xfin(1),Xfin(2));
for i =1:n
    fprintf(f,'%g\t',Xchemin(i));
end
fprintf(f,'\n');
for i =1:n
    fprintf(f,'%g\t',Ychemin(i));
end
fclose(f);

%% La part du robot C
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
