function [nbc,d]=choixdechemin(data,xc1,yc1,c1j,xc2,yc2,c2j,xi,yi,xa,ya,l)

obstacles=data;
% 格式默认为N*M矩阵，列数为4即默认为四点，行数为2*n，n是obstacle个数
[m,n]=size(obstacles);
ndob=m/2;
dis(1)=distance(xc1,yc1,c1j,xi,yi,xa,ya);
dis(2)=distance(xc2,yc2,c2j,xi,yi,xa,ya);
dis(3)=0;
if dis(1)<=dis(2)
    n1=1;
else
    n1=2;
end
j1=0;
j2=0;
obx=[];
oby=[];
for i=1:ndob
    obx=[obx;obstacles(2*i-1,:)];
    oby=[oby;obstacles(2*i,:)];
end
cj1=c1j+2;
cj2=c2j+2;
x1c=[xa,xc1,xi];
y1c=[ya,yc1,yi];
x2c=[xa,xc2,xi];
y2c=[ya,yc2,yi];

for i=1:ndob
    for j=1:cj1-1
        ca=[x1c(j),y1c(j)];
        ci=[x1c(j+1),y1c(j+1)];
        j1=j1+interieur(obx(i,:), oby(i,:),ca, ci, l);
        %j1
        %plot([ca(1),ci(1)],[ca(2),ci(2)])
        %hold on
    end
end

for i=1:ndob
    for j=1:cj2-1
        ca=[x2c(j),y2c(j)];
        ci=[x2c(j+1),y2c(j+1)];
        j2=j2+interieur(obx(i,:), oby(i,:),ca, ci, l);
        %j2
        %plot([ca(1),ci(1)],[ca(2),ci(2)])
        %hold on
    end
end
 
if (j1==0 && j2==0)
    nbc=n1;
else if (j1~=0 && j2==0)
        nbc=2;
    else if (j1==0 && j2~=0)
             nbc=1;
        else
             nbc=3;
        end
    end
end
d=dis(nbc);
end
