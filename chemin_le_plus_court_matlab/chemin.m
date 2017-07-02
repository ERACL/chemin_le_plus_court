function [Xres, Yres] = chemin(X, Y, l)
% Ce function va calculer les point equivalent.
% Input:
%   X, Y: Coordonee du point en reel, de 1*m
%   l: Longueur propre du robot.
% Output:
%   Xres, Yres: Coordonee du point equivalent, de 1*2m
[K1,B1]=point1(X,Y,l);
[K2,B2]=point2(X,Y,l);
K=[K2;K1];
K=K(:);
B=[B2;B1];
B=B(:);
K=[K;K(1)];
B=[B;B(1)];
[n,m]=size(X);
Xres=zeros(1,2*m);
Yres=zeros(1,2*m);
for i=1:2*m
    Xres(i)=(B(i+1)-B(i))/(K(i)-K(i+1));
    Yres(i)=K(i)*Xres(i)+B(i);
end
% plot(X,Y,'+',Xres,Yres,'*')
% axis equal
