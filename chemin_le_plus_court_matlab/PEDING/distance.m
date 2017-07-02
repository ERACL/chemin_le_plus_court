function d=distance(x,y,c,xi,yi,xa,ya)
% calculer le length d'un chemin
if c~=1
    d=sqrt((xa-x(1))*(xa-x(1))+(ya-y(1))*(ya-y(1)));
    for i = 1:c-1
        d=d+sqrt((x(i)-x(i+1))*(x(i)-x(i+1))+(y(i)-y(i+1))*(y(i)-y(i+1)));
    end
    d=d+sqrt((xi-x(c))*(xi-x(c))+(yi-y(c))*(yi-y(c)));
else
    d=sqrt((xa-x)*(xa-x)+(ya-y)*(ya-y))+sqrt((xi-x)*(xi-x)+(yi-y)*(yi-y));
end
end