function WUma(ff,source)
SNR_dB=-10:1:10;     
SNR=10.^(SNR_dB/10);
N=length(source);
t=0:0.02:4; %fefine the ?interval of the s0 and s1   
w1=2*ff(1)*pi;
w2=4*ff(2)*pi;
A=2;
%2FSK调制
s0_2FSK=A*sin(w1*t);s1_2FSK=A*sin(w2*t);
%每个码元的能量             
E_2FSK=(sum(s0_2FSK.^2)+sum(s1_2FSK.^2))/2;
%错误个数的数组初始化
error_2FSK=zeros(1,length(SNR));
%误码率数组初始化
Pe_2FSK_actual=zeros(1,length(SNR));
 
for i=1:length(SNR) %在每个snr对应下的Pe
    %噪声的能量
    n0_2FSK=E_2FSK/SNR(i);
    for j=1:N     %白噪声方差等于功率  红色为方差，均值为0，因为没加m
        %生成噪声  %randn产生正态分布的随机数或矩阵的函数
        noise_2FSK=sqrt(n0_2FSK/2)*randn(1,length(t));
        %如果发送的为0,收到码元后判决为1，则出错。
        if source(j)==0
            %2FSK的判决
            I_2FSK=sum((s0_2FSK+noise_2FSK).*(s1_2FSK-s0_2FSK));
            beta_2FSK=0.5*(sum(s1_2FSK.^2)-sum(s0_2FSK.^2));%判决门限
            if I_2FSK>beta_2FSK
                error_2FSK(i)=error_2FSK(i)+1;
            end
        else   %如果发送的为1,收到码元后判决为0，则出错。              
            %2FSK的判决
            I_2FSK=sum((s1_2FSK+noise_2FSK).*(s1_2FSK-s0_2FSK));
            beta_2FSK=0.5*(sum(s1_2FSK.^2)-sum(s0_2FSK.^2));%判决门限
            if I_2FSK<beta_2FSK
                error_2FSK(i)=error_2FSK(i)+1;
            end
        end             
    end
    %误码率的计算
    Pe_2FSK_actual(i)=error_2FSK(i)/N;
end
figure(11)
%绘制仿真的Pe的曲线
semilogy(SNR_dB,Pe_2FSK_actual,'o');hold on;
%理论的Pe
Pe_2FSK_theory=0.5*erfc(sqrt(0.5*SNR));
%绘制理论的Pe的曲线
semilogy(SNR_dB,Pe_2FSK_theory,'g-');hold on;
legend('2FSK误码率理论曲线','2FSK仿真数据');
grid on;
xlabel('E/n0(dB)');ylabel('误码率Pe');
title('2FSK误码');
end

