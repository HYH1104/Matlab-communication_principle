%%%%%%%%%%%%
%fsk�������%
%%%%%%%%%%%%
function fskbian=FSKbian(X,f,fs)
%   2FSK����
%   ��������Ƶĵ����Բ���������sample����Ԫ����Rb
%   ����Ƶ��[f0 f1]
%   fsΪ�����źŵķ���Ƶ��      
dt = 1/fs;
f1 = f(1);
f2 = f(2);  %A�����źŵ�Ƶ��
[~,xx]=size(X);
g1 = X;
g2 = ~X; %�źŷ�ת����g1����
g11 = (ones(1,fs))'*g1 ;%����
g11(:);
g1a = g11(:)' ;
g21 = (ones(1,fs))'*g2;
g2a = g21(:)';
t = 0 :dt:xx-dt;
fsk1 = g1a.*cos(2*pi*f1.*t);
fsk2 = g2a.*cos(2*pi*f2.*t);
fskbian = fsk1+fsk2;    %  �����ź�
end