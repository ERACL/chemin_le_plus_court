function k = pointc(x,y,cj,xi,yi,xa,ya)
k=1;
for i=1:cj
    da=sqrt((xa-x(i))*(xa-x(i))+(ya-y(i))*(ya-y(i)));
	di=sqrt((xi-x(i))*(xi-x(i))+(yi-y(i))*(yi-y(i)));
	p(i)=di/da;
end
for i=1:cj
	if p(k)>=p(i)
		k=i;
    end
end
end
    