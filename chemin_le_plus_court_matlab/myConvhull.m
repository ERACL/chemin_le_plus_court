function p = myConvhull(X,Y)
P = [X; Y];
[m, n] = size(P);
p=[]; %����ı��
for i=1:n
    b=P(:,i);
    A=P;
    A(:,i)=[];
    [x,~,flag]=myLinprog(ones(n-1,1),[],[],[ones(1,n-1);A],[1;b],zeros(n-1,1),ones(n-1,1));
    %�����Թ滮�Ľ⣬�޽���Ƕ��㣬�н�Ƕ���
    if flag<0
        p=[p,i]; %��¼����ı��
    end
end