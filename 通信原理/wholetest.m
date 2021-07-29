%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                    %
%       ֻ������һ����ֻ������һ����ֻ������һ������Ҫ������˵����       %
%                                                                    %
%�����������в���,��������ʾÿ�δ���Ľ��������ʾ��ͬ������µ�ʧ������%
%                                                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
clear all
close all
warning off
%%
%�źŲ���
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
ff=[1,2];%A�����źŵ�Ƶ��
%%
%ԭʼ�ź�
figure(1);
plot(t,xt);hold on;
stem(t1,st,'.','b');
title('ԭʼ�źż�������ź�');
%%
%PCM ����
pcm_bian = PCMbian(st);
figure(2);
stairs(pcm_bian);
title('PCM����');
%%
%�������
jjbian=JJbian(pcm_bian);
figure(3);
stairs(jjbian);
title('�������');
%%
%��֯����
jzbian=JZbian(jjbian);
figure(4);
stairs(jzbian);
title('��֯����');
%%
%FSK����
fskbian=FSKbian(jzbian,ff,fs);
figure(5);
plot(fskbian);
title('FSK����'); 
%%
%����
noise=fskbian+ZS(fskbian,30);
%%
%���
fskjie=FSKjie(fskbian,ff,fs);
figure(6);
plot(fskjie);
title('FSK���');
%%
%��֯����
jzjie=JZjie(fskjie);
figure(7);
stairs(jzjie);
title('��֯����');
%%
%�������
jjjie=JJjie(jzjie);
figure(8);
stairs(jjjie);              
title('�������');
%%
% PCM ����
pcm_jie = PCMjie(jjjie,max);
figure(9);
plot(t1,pcm_jie);
title('PCM����');
grid on;
%%
%�ȶ�ԭʼ�ź�������ź�
figure(10);
plot(t,xt,'g',t1,pcm_jie,'r');
legend('ԭʼ�ź�','�����ź�')
title('ԭʼͼ���ڽ�����ͼ����жԱ�');
%%
%����ʧ��� 
[~,z1]=size(pcm_bian);
[~,z2]=size(jjjie);
if z1==z2
[err,ber] = biterr(pcm_bian,jjjie);
fprintf('ʧ����ǣ�%.6f',ber);
disp('%');
else
disp('����')
end
%%
%������������������
WUma(ff,jzbian);
%%
%ԭʼ�����ź�Ƶ��
pp1=fft(st);
figure(12);
stem(pp1);
title('ԭʼ�����ź�Ƶ��');
%%
%FSK���ƺ��ź�Ƶ��
pp2=fft(fskbian);
figure(13);
stem(pp2);
title('FSK���ƺ��ź�Ƶ��');
%%
%FSK���ƺ�������ź�Ƶ��
pp3=fft(noise);
figure(14);
stem(pp3);
title('FSK���ƺ�������ź�Ƶ��');
%%
%PCM������ź�Ƶ��
pp4=fft(pcm_jie);
figure(15);
stem(pp4);
title('PCM������ź�Ƶ��');