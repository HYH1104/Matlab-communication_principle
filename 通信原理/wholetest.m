%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                    %
%       只运行这一个，只运行这一个，只运行这一个，重要的事情说三遍       %
%                                                                    %
%单次完整运行测试,并单独显示每次处理的结果，不显示不同信噪比下的失真度情况%
%                                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
warning off
%%
%信号参数
T=0.05;
t=-1:T:1;
sdt=T/2;
t1=-1:sdt:1;
NN=2/sdt;
% xt=exp(5*t);
% st=exp(5*t1);
xt=cos(2*pi*t)+sin(0.5*pi*t);
st=cos(2*pi*t1)+sin(0.5*pi*t1);
max = max(abs(st));
fs = 100;
ff=[1,2];%A两个信号的频率
%%
%原始信号
figure(1);
plot(t,xt);hold on;
stem(t1,st,'.','b');
title('原始信号及其抽样信号');
%%
%PCM 编码
pcm_bian = PCMbian(st);
figure(2);
stairs(pcm_bian);
title('PCM编码');
%%
%卷积编码
jjbian=JJbian(pcm_bian);
figure(3);
stairs(jjbian);
title('卷积编码');
%%
%交织编码
jzbian=JZbian(jjbian);
figure(4);
stairs(jzbian);
title('交织编码');
%%
%FSK调制
fskbian=FSKbian(jzbian,ff,fs);
figure(5);
plot(fskbian);
title('FSK调制'); 
%%
%噪声
noise=fskbian+ZS(fskbian,30);
%%
%解调
fskjie=FSKjie(fskbian,ff,fs);
figure(6);
plot(fskjie);
title('FSK解调');
%%
%交织解码
jzjie=JZjie(fskjie);
figure(7);
stairs(jzjie);
title('交织解码');
%%
%卷积解码
jjjie=JJjie(jzjie);
figure(8);
stairs(jjjie);              
title('卷积解码');
%%
% PCM 解码
pcm_jie = PCMjie(jjjie,max);
figure(9);
plot(t1,pcm_jie);
title('PCM解码');
grid on;
%%
%比对原始信号与解码信号
figure(10);
plot(t,xt,'g',t1,pcm_jie,'r');
legend('原始信号','解码信号')
title('原始图像于解码后的图像进行对比');
%%
%计算失真度 
[~,z1]=size(pcm_bian);
[~,z2]=size(jjjie);
if z1==z2
[err,ber] = biterr(pcm_bian,jjjie);
fprintf('失真度是：%.6f',ber);
disp('%');
else
disp('有误')
end
%%
%加入噪声计算误码率
WUma(ff,jzbian);
%%
%原始抽样信号频谱
pp1=fft(st);
figure(12);
stem(pp1);
title('原始抽样信号频谱');
%%
%FSK调制后信号频谱
pp2=fft(fskbian);
figure(13);
stem(pp2);
title('FSK调制后信号频谱');
%%
%FSK调制后加噪声信号频谱
pp3=fft(noise);
figure(14);
stem(pp3);
title('FSK调制后加噪声信号频谱');
%%
%PCM解码后信号频谱
pp4=fft(pcm_jie);
figure(15);
stem(pp4);
title('PCM解码后信号频谱');