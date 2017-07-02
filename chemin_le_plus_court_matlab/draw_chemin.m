function draw_chemin(varargin)
%function draw_chemin()
%function draw_chemin(adresse)
%
%   Ce fonction est pour afficher le chemin.
adresse = 'E:\Onedrive\Documents\Lonaparte-PC\Codes\PE\Mission_3_chemin\';
if nargin>0
    adresse = varargin;
end
fr=importdata(strcat(adresse, 'data_initial.txt'));
data=fr;
[m, n]=size(data);
l = data(m,1);
angle = data(m,2);
obstacle = data(1:(m-3),:);
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
obstacle = [obstacle, obstacle(:,1)];
plot([Xini(1),Xfin(1)],[Xini(2),Xfin(2)],'*b',Xchemin, Ychemin, '-g', obstacle(1,:), obstacle(2,:), '-r');
axis equal