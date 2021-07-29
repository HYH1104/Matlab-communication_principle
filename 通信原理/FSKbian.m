%%%%%%%%%%%%
%fsk解调函数%
%%%%%%%%%%%%
function fskbian=FSKbian(X,f,fs)
%   2FSK调制
%   输入待调制的单极性不归零序列sample和码元速率Rb
%   发送频率[f0 f1]
%   fs为发送信号的发送频率      
dt = 1/fs;
f1 = f(1);
f2 = f(2);  %A两个信号的频率
[~,xx]=size(X);
g1 = X;
g2 = ~X; %信号翻转，和g1反向
g11 = (ones(1,fs))'*g1 ;%抽样
g11(:);
g1a = g11(:)' ;
g21 = (ones(1,fs))'*g2;
g2a = g21(:)';
t = 0 :dt:xx-dt;
fsk1 = g1a.*cos(2*pi*f1.*t);
fsk2 = g2a.*cos(2*pi*f2.*t);
fskbian = fsk1+fsk2;    %  产生信号
end