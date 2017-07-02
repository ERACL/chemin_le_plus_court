function [Xres,Yres] = cheminLePlusCourt(X,Y,Xini,Xfin,l,obstacle) 
% Ce function est pour rechercher le chemin le plus court.
ancienAngle = 0;
angle = 0; %%(en degres)
% lire les datas
xa=Xini(1);
ya=Xini(2);      %%coordonne ancien
xi=Xfin(1);
yi=Xfin(2);
ca=[xa,ya];
ci=[xi,yi];
n=length(X);
x=X;
y=Y;
c1j=1;
c2j=1;
%% chercher 2 chemin
for i = 1:n
	j_p=judge_point(x(i),y(i),xi,yi,xa,ya);
	if j_p==0
        xc1(c1j)=x(i);
		yc1(c1j)=y(i);
		c1j=c1j+1;
    else
		xc2(c2j)=x(i);
		yc2(c2j)=y(i);
		c2j=c2j+1;
    end
end
c1j=c1j-1;
c2j=c2j-1;
c1=c1j;
c2=c2j;
%% mis en ordre
for i = 1:c1j
	jp=pointc(xc1,yc1,c1,xi,yi,xa,ya);
	changep=xc1(jp);
	xc1(jp)=xc1(c1);
	xc1(c1)=changep;
	changep=yc1(jp);
	yc1(jp)=yc1(c1);
	yc1(c1)=changep;
	c1=c1-1;
end
for i = 1:c2j
	jp=pointc(xc2,yc2,c2,xi,yi,xa,ya);
	changep=xc2(jp);
	xc2(jp)=xc2(c2);
	xc2(c2)=changep;
	changep=yc2(jp);
	yc2(jp)=yc2(c2);
	yc2(c2)=changep;
	c2=c2-1;
end

%% chercher le plus court
[nbc,d]=choixdechemin(obstacle,xc1,yc1,c1j,xc2,yc2,c2j,xi,yi,xa,ya,l);
if nbc==1
	Xres=xc1;
	Yres=yc1;
end
if nbc==2
	Xres=xc2;
	Yres=yc2;
end
if (nbc~=1 && nbc~=2)
	Xres=0;
	Yres=0;
end
