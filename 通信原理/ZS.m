%%%%%%%%%%%%%
%�����������%
%%%%%%%%%%%%%
function noise= ZS(input,sng)
%�������
noise = awgn(input,0.1*sng);
end