%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%卷积解码函数中用到的路径值计算函数%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function d = dist(X1,X2,n)
sum=0;
for i=1:n
    if X1(i)~=X2(i)
        sum=sum+1;
    end
end
d=sum;
end