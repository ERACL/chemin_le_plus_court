function [ K, B ] = point2( X, Y, l )
X=[X,X(1)];
Y=[Y,Y(1)];
[n,m]=size(X);
X1=zeros(1,m);
Y1=zeros(1,m);
m=m-1;
K=zeros(1,m+1);
K1=zeros(1,m+1);
B=zeros(1,m+1);
for i=1:m
    if X(i)==X(i+1)
        K(i)=100000*l+10000*(max(X)-min(X));
    else
        K(i)=(Y(i+1)-Y(i))/(X(i+1)-X(i));
    end
end
X(m+1)=X(1);
Y(m+1)=Y(1);
x=zeros(1,6);
y=zeros(1,6);
x1=zeros(1,4);
y1=zeros(1,4);
k=zeros(1,6);
for i=2:(m+1)
    if K(i)*K(i-1) == 1
        k0 = 100000*l+10000*(max(X)-min(X));
        k1_test = 1/sqrt(2);
        k2_test = -1/sqrt(2);
    else
        k0=(K(i)+K(i-1))/(1-K(i)*K(i-1));
        temp=roots([k0,2,-k0]);
        if size(temp)== [2,1]
            k1_test=temp(1);
            k2_test=temp(2);
        else
            k1_test=temp;
            k2_test=temp;
        end
    end
    if (k1_test == 0) | (k2_test == 0)
        k1_test = 100000*l+10000*(max(X)-min(X));
        k2_test = 1/(100000*l+10000*(max(X)-min(X)));
    end
    x(1)=X(i)+real(l/sqrt(1+k1_test*k1_test));
    y(1)=Y(i)+real(k1_test*l/sqrt(1+k1_test*k1_test));
    x(2)=X(i)+real(l/sqrt(1+k2_test*k2_test));
    y(2)=Y(i)+real(k2_test*l/sqrt(1+k2_test*k2_test));
    x(3)=X(i)-real(l/sqrt(1+k1_test*k1_test));
    y(3)=Y(i)-real(k1_test*l/sqrt(1+k1_test*k1_test));
    x(4)=X(i)-real(l/sqrt(1+k2_test*k2_test));
    y(4)=Y(i)-real(k2_test*l/sqrt(1+k2_test*k2_test));
    x1(1)=X(i)+real(l/100/sqrt(1+k1_test*k1_test));
    y1(1)=Y(i)+real(k1_test*l/100/sqrt(1+k1_test*k1_test));
    x1(2)=X(i)+real(l/100/sqrt(1+k2_test*k2_test));
    y1(2)=Y(i)+real(k2_test*l/100/sqrt(1+k2_test*k2_test));
    x1(3)=X(i)-real(l/100/sqrt(1+k1_test*k1_test));
    y1(3)=Y(i)-real(k1_test*l/100/sqrt(1+k1_test*k1_test));
    x1(4)=X(i)-real(l/100/sqrt(1+k2_test*k2_test));
    y1(4)=Y(i)-real(k2_test*l/100/sqrt(1+k2_test*k2_test));
    x(5)=x(1);
    x(6)=x(2);
    y(5)=y(1);
    y(6)=y(2);
    k=[k2_test,k1_test,k2_test,k1_test,k2_test,k1_test];
    for j=1:4
        if inpolygon(x1(j),y1(j),X,Y)
            X1(i)=x(j+2);
            Y1(i)=y(j+2);
            K1(i)=real(k(j+2));
            B(i)=Y1(i)-K1(i)*X1(i);
            break;
        end
    end
    %plot(X,Y,'-',x1,y1,'*')
end
X1(1)=X1(m+1);
Y1(1)=Y1(m+1);
X1(m+1)=[];
Y1(m+1)=[];
K1(1)=K1(m+1);
K1(m+1)=[];
K=K1;
B(1)=B(m+1);
B(m+1)=[];
%plot(X,Y,'+',X1,Y1,'*')
end

