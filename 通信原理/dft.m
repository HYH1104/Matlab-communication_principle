function [Xk]=dft(xn)%输入离散序列xn，输出DFT结果的幅值Xk。横坐标k
M=length(xn);
n=[1:1:M];
k=[1:1:M];
WM=exp(-j*2*pi/M);
nk=n'*k;
WMnk=WM.^nk;
Xk=xn.*WMnk;
Xk=abs(Xk);
end