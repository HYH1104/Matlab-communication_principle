%%%%%%%%%%%%%
%Ìí¼ÓÔëÉùº¯Êı%
%%%%%%%%%%%%%
function noise= ZS(input,sng)
%Ìí¼ÓÔëÉù
noise = awgn(input,0.1*sng);
end