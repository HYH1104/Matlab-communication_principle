%%%%%%%%%%%%%
%卷积编码函数%
%%%%%%%%%%%%%
function jjbian=JJbian(X)
tre1 = poly2trellis(3,[4 5 7]); %卷积码的生成多项式
jjbian = convenc(X,tre1); %卷积编码
end
% function jjbian = JJbian( X )
% len=length(X);
% T=zeros(1,len+3,'int8');
% F=zeros(1,len*3,'int8');
% for i=4:len+3
%     T(i)=X(i-3);
% end
% for i=1:len
%     F(3*(i-1)+1)=T(i+3);
%     F(3*(i-1)+2)=xor(T(i+3),T(i+1));
%     F(3*(i-1)+3)=xor(xor(T(i+3),T(i+2)),T(i+1));
% end
% jjbian=F;
% end