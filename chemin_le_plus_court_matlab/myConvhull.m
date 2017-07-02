function p = myConvhull(X,Y)
P = [X; Y];
[m, n] = size(P);
p=[]; %顶点的编号
for i=1:n
    b=P(:,i);
    A=P;
    A(:,i)=[];
    [x,~,flag]=myLinprog(ones(n-1,1),[],[],[ones(1,n-1);A],[1;b],zeros(n-1,1),ones(n-1,1));
    %求线性规划的解，无解就是顶点，有解非顶点
    if flag<0
        p=[p,i]; %记录顶点的编号
    end
end