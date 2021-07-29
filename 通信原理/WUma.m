function WUma(ff,source)
SNR_dB=-10:1:10;     
SNR=10.^(SNR_dB/10);
N=length(source);
t=0:0.02:4; %fefine the ?interval of the s0 and s1   
w1=2*ff(1)*pi;
w2=4*ff(2)*pi;
A=2;
%2FSK����
s0_2FSK=A*sin(w1*t);s1_2FSK=A*sin(w2*t);
%ÿ����Ԫ������             
E_2FSK=(sum(s0_2FSK.^2)+sum(s1_2FSK.^2))/2;
%��������������ʼ��
error_2FSK=zeros(1,length(SNR));
%�����������ʼ��
Pe_2FSK_actual=zeros(1,length(SNR));
 
for i=1:length(SNR) %��ÿ��snr��Ӧ�µ�Pe
    %����������
    n0_2FSK=E_2FSK/SNR(i);
    for j=1:N     %������������ڹ���  ��ɫΪ�����ֵΪ0����Ϊû��m
        %��������  %randn������̬�ֲ�������������ĺ���
        noise_2FSK=sqrt(n0_2FSK/2)*randn(1,length(t));
        %������͵�Ϊ0,�յ���Ԫ���о�Ϊ1�������
        if source(j)==0
            %2FSK���о�
            I_2FSK=sum((s0_2FSK+noise_2FSK).*(s1_2FSK-s0_2FSK));
            beta_2FSK=0.5*(sum(s1_2FSK.^2)-sum(s0_2FSK.^2));%�о�����
            if I_2FSK>beta_2FSK
                error_2FSK(i)=error_2FSK(i)+1;
            end
        else   %������͵�Ϊ1,�յ���Ԫ���о�Ϊ0�������              
            %2FSK���о�
            I_2FSK=sum((s1_2FSK+noise_2FSK).*(s1_2FSK-s0_2FSK));
            beta_2FSK=0.5*(sum(s1_2FSK.^2)-sum(s0_2FSK.^2));%�о�����
            if I_2FSK<beta_2FSK
                error_2FSK(i)=error_2FSK(i)+1;
            end
        end             
    end
    %�����ʵļ���
    Pe_2FSK_actual(i)=error_2FSK(i)/N;
end
figure(11)
%���Ʒ����Pe������
semilogy(SNR_dB,Pe_2FSK_actual,'o');hold on;
%���۵�Pe
Pe_2FSK_theory=0.5*erfc(sqrt(0.5*SNR));
%�������۵�Pe������
semilogy(SNR_dB,Pe_2FSK_theory,'g-');hold on;
legend('2FSK��������������','2FSK��������');
grid on;
xlabel('E/n0(dB)');ylabel('������Pe');
title('2FSK����');
end

