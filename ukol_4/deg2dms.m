function [v]=deg2dms(st)
%pøevod stupnì v desetinné podobì na stupnì vteøiny a minuty
%vstup:
%   st-matice stupòù v desetinné podobì
%výstup:
%   v-matice [s m v]
[r,s]=size(st); q=0;
if r<s
    st=st';
    q=1;
end

r=length(st);
v=ones(r,3);
for i=1:r
    s=abs(fix(st(i,1)));
    m1=((abs(st(i,1))-abs(fix(st(i,1))))*60);
    m=fix(m1);
    vt=(m1-fix(m1))*60;
    if round(vt)==60
        vt=0;
        m=0;
        s=s+1;
    end
    if round(vt,2)==0
        vt=0;
    end
    v(i,1)=s;
    v(i,2)=m;
    v(i,3)=vt;
    if st(i,1)<0
        if s~=0
            v(i,1)=s*(-1);
        elseif s==0&&m~=0
            v(i,2)=m*(-1);
        else s==0&&m==0
            v(i,3)=vt*(-1);
        end
    end
end
if q==1
    v=v';
end
end