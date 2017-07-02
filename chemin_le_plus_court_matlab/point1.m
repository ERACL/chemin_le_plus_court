function [ K , B ] = point1( X, Y, l )
l = l*1.05;
X=[X,X(1)];
Y=[Y,Y(1)];
[n,m]=size(X);
m=m-1;
X1=zeros(1,m);
Y1=zeros(1,m);
K=zeros(1,m);
B=zeros(1,m);
for i=1:m
    if X(i)==X(i+1)
        k=100000*l+10000*(max(X)-min(X));
    else
        k=(Y(i+1)-Y(i))/(X(i+1)-X(i));
    end
    K(i)=k;
    b=Y(i)-k*X(i);
    d=l*sqrt(1+k*k);
    b1=b+d;
    b2=b-d;
    if k==0
        kt=100000*l+10000*(max(X)-min(X));
    else
        kt=-1/k;
    end
    bt=(Y(i+1)+Y(i))/2-kt*(X(i+1)+X(i))/2;
    xt=(bt-(b+d/100000))/(k-kt);
    yt=kt*xt+bt;
    if inpolygon(xt,yt,X,Y)
        b=b2;
    else
        b=b1;
    end
    B(i)=b;
end
end

