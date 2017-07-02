function ind = interieur(X, Y, Xini, Xfin, l)
% Ce fonction est pour justifier si l'obstacle est dans le chemin du robot.
% [Xres, Yres] = interieur(X, Y, Xini, Xfin, l, angle)
% input: 
%       X, Y: coordonate des obstacles
%       Xini: [x de initial, y de initial]
%       Xfin: [x de finir, y de finir]
%       l: longueur propre
% output:
%	1: si l'obstacle est dans le chemin.
%	0: si l'obstacle n'est pas dans le chemin.
x1 = Xini(1);
x2 = Xfin(1);
y1 = Xini(2);
y2 = Xfin(2);
if y2 > y1
    alpha = atan((x2 - x1)/(y2 - y1));
elseif (y2 < y1) && (x2 < x1)
    alpha = atan((x2 - x1)/(y2 - y1)) - pi;
elseif (y2 < y1) && (x2 >= x1)
    alpha = pi - atan((x2 - x1)/(y1 - y2));
elseif (y2 == y1) && (x2 < x1)
    alpha = -pi/2;
else 
    alpha = pi/2;
end
x1 = Xini(1)-l*cos(alpha)-l*sin(alpha);
y1 = Xini(2)+l*sin(alpha)-l*cos(alpha);
x2 = Xini(1)+l*cos(alpha)-l*sin(alpha);
y2 = Xini(2)-l*sin(alpha)-l*cos(alpha);
x3 = Xfin(1)-l*cos(alpha)+l*sin(alpha);
y3 = Xfin(2)+l*sin(alpha)+l*cos(alpha);
x4 = Xfin(1)+l*cos(alpha)+l*sin(alpha);
y4 = Xfin(2)-l*sin(alpha)+l*cos(alpha);
[n, m]=size(X);
X = [X, X(1)];
Y = [Y, Y(1)];
X1 = [];
Y1 = [];
for i = 1:m
    Xtemp = linspace(X(i),X(i+1),100);
    Ytemp = linspace(Y(i),Y(i+1),100);
    X1 = [X1, Xtemp];
    Y1 = [Y1, Ytemp];
end
[n,m]=size(X1);
ind = 0;
for i = 1:m
    if inpolygon(X1(i),Y1(i),[x1,x2,x3,x4],[y1,y2,y3,y4])
        ind = 1;
        break;
    end
end
%plot([x1,x2,x4,x3,x1],[y1,y2,y4,y3,y1])
%hold on
%plot([Xini(1),Xfin(1)],[Xini(2),Xfin(2)])
%hold on 
    
