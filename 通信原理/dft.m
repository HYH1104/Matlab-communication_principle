function [Xk]=dft(xn)%������ɢ����xn�����DFT����ķ�ֵXk��������k
M=length(xn);
n=[1:1:M];
k=[1:1:M];
WM=exp(-j*2*pi/M);
nk=n'*k;
WMnk=WM.^nk;
Xk=xn.*WMnk;
Xk=abs(Xk);
end