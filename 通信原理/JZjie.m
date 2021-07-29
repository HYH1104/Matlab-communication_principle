%%%%%%%%%%%%%
%交织解码函数%
%%%%%%%%%%%%%
function jzjie=JZjie(X)
  for i=1:27
   for j=1:72
      M(i,j)=X(72*(i-1)+j);
   end
  end
  for j=1:72
   for i=1:27
      jzjie((27*(j-1))+i)=M(i,j);
   end
  end
end