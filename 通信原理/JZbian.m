%%%%%%%%%%%%%
%½»Ö¯±àÂëº¯Êý%
%%%%%%%%%%%%%
function jzbian=JZbian(X)
A=reshape(X,[27 72]);
  for i=1:27
   for j=1:72
      jzbian(72*(i-1)+j)=A(i,j);
   end
  end
end