%%%%%%%%%%%%%
%卷积解码函数%
%%%%%%%%%%%%%
function jjjie = JJjie( X )
len=length(X);
Path=zeros(4,len/3,'int8');%4条幸存路径
Path_t=zeros(4,len/3,'int8');
Da=0;Db=0;Dc=0;Dd=0;%抵达a,b,c,d总汉明距离
Pa=1;Pb=2;Pc=3;Pd=4;%a,b,c,d路径指针
T(9)=0;
for i=1:9
    T(i)=X(i);
end
%a
tp1=dist(T,[0 0 0 0 0 0 0 0 0],9);
tp2=dist(T,[1 1 1 0 0 1 0 1 1],9);
if(tp1<tp2)
    Da=tp1;
    Path(1,1)=0;Path(1,2)=0;Path(1,3)=0;
else
    Da=tp2;
    Path(1,1)=1;Path(1,2)=0;Path(1,3)=0;
end
%b
tp1=dist(T,[0 0 0 0 0 0 1 1 1],9);
tp2=dist(T,[1 1 1 0 0 1 1 0 0],9);
if(tp1<tp2)
    Db=tp1;
    Path(2,1)=0;Path(2,2)=0;Path(2,3)=1;
else
    Db=tp2;
    Path(2,1)=1;Path(2,2)=0;Path(2,3)=1;
end
%c
tp1=dist(T,[0 0 0 1 1 1 0 0 1],9);
tp2=dist(T,[1 1 1 1 1 0 0 1 0],9);
if(tp1<tp2)
    Dc=tp1;
    Path(3,1)=0;Path(3,2)=1;Path(3,3)=0;
else
    Dc=tp2;
    Path(3,1)=1;Path(3,2)=1;Path(3,3)=0;
end
%d
tp1=dist(T,[0 0 0 1 1 1 1 1 0],9);
tp2=dist(T,[1 1 1 1 1 0 1 0 1],9);
if(tp1<tp2)
    Dd=tp1;
    Path(4,1)=0;Path(4,2)=1;Path(4,3)=1;
else
    Dd=tp2;
    Path(4,1)=1;Path(4,2)=1;Path(4,3)=1;
end
%迭代
Dat=0;Dbt=0;Dct=0;Ddt=0;%交换缓冲
fga=0;fgb=0;fgc=0;fgd=0;%路径标志
rmSz=int32((len-9)/3);
for i=1:rmSz
    T(1)=X(9+(i-1)*3+1);
    T(2)=X(9+(i-1)*3+2);
    T(3)=X(9+(i-1)*3+3);
    %a
    tp1=dist(T,[0 0 0],3)+Da;
    tp2=dist(T,[0 1 1],3)+Dc;
    if(tp1<tp2)
        Dat=tp1;
        fga=0;
    else
        Dat=tp2;
        fga=1;
    end
    %b
    tp1=dist(T,[1 1 1],3)+Da;
    tp2=dist(T,[1 0 0],3)+Dc;
    if(tp1<tp2)
        Dbt=tp1;
        fgb=0;
    else
        Dbt=tp2;
        fgb=1;
    end
    %c
    tp1=dist(T,[0 0 1],3)+Db;
    tp2=dist(T,[0 1 0],3)+Dd;
    if(tp1<tp2)
        Dct=tp1;
        fgc=0;
    else
        Dct=tp2;
        fgc=1;
    end
    %d
    tp1=dist(T,[1 1 0],3)+Db;
    tp2=dist(T,[1 0 1],3)+Dd;
    if(tp1<tp2)
        Ddt=tp1;
        fgd=0;
    else
        Ddt=tp2;
        fgd=1;
    end
    %更新幸存路径
    %a
    if(fga==0)
        Path_t(Pa,:)=Path(Pa,:);
        Path_t(Pa,3+i)=0;
        Da=Dat;
    else
        Path_t(Pa,:)=Path(Pc,:);
        Path_t(Pa,3+i)=0;
        Da=Dat;
    end
    %b
    if(fgb==0)
        Path_t(Pb,:)=Path(Pa,:);
        Path_t(Pb,3+i)=1;
        Db=Dbt;
    else
        Path_t(Pb,:)=Path(Pc,:);
        Path_t(Pb,3+i)=1;
        Db=Dbt;
    end
    %c
    if(fgc==0)
        Path_t(Pc,:)=Path(Pb,:);
        Path_t(Pc,3+i)=0;
        Dc=Dct;
    else
        Path_t(Pc,:)=Path(Pd,:);
        Path_t(Pc,3+i)=0;
        Dc=Dct;
    end
    %d
    if(fgd==0)
        Path_t(Pd,:)=Path(Pb,:);
        Path_t(Pd,3+i)=1;
        Dd=Ddt;
    else
        Path_t(Pd,:)=Path(Pd,:);
        Path_t(Pd,3+i)=1;
        Dd=Ddt;
    end
    %
    Path(Pa,:)=Path_t(Pa,:);
    Path(Pb,:)=Path_t(Pb,:);
    Path(Pc,:)=Path_t(Pc,:);
    Path(Pd,:)=Path_t(Pd,:);
end
k=min([Da Db Dc Dd]);
if(k==Da)
    jjjie=Path(Pa,:);
end
if(k==Db)
    jjjie=Path(Pb,:);
end
if(k==Dc)
    jjjie=Path(Pc,:);
end
if(k==Dd)
    jjjie=Path(Pd,:);
end
end
