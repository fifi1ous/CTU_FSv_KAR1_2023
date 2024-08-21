clc; clear; format long G
RAD=pi/180;

lam=[14,20,0];
[lam]=dms2deg(lam);
LAM=lam*RAD;
fi=[49,50,0];
[fi]=dms2deg(fi);
FI=fi*RAD;

wx=[0,0,4.9984]; [wx]=dms2deg(wx); wx=wx*RAD;
wy=[0,0,1.5867]; [wy]=dms2deg(wy); wy=wy*RAD;
wz=[0,0,5.2611]; [wz]=dms2deg(wz); wz=wz*RAD;

m=-3.5623e-6; m=m+1;
DX=-570.8285; DY=-85.6769; DZ=-462.8420;

Rx=[1,0,0;0,cos(wx),sin(wx);0,-sin(wx),cos(wx)];
Ry=[cos(wy),0,-sin(wy);0,1,0;sin(wy),0,cos(wy)];
Rz=[cos(wz),sin(wz),0;-sin(wz),cos(wz),0;0,0,1];
R=Rx*Ry*Rz;
d=[DX;DY;DZ];

%WGS 84
a=6378137;b=6356752.314;
e=(a^2-b^2)/(a^2);
W=sqrt(1-e*(sin(FI)^2));
N=a/W;
P=[cos(FI)*cos(LAM);cos(FI)*sin(LAM);(1-e)*sin(FI)];P=P*N;

XYZ=m*R*P+d;
X=XYZ(1);Y=XYZ(2);Z=XYZ(3);

% KONSTANTY
% BESSEL
a=6377397.155;
b=6356078.9633;
e=(a^2-b^2)/(a^2);

LAM=atan2(Y,X);L=asin(Y/sqrt(X^2+Y^2));kontr=LAM-L;
[LAM1]=deg2dms(LAM/RAD);

% 1. aproximace
B=atan2(Z,sqrt(X^2+Y^2)*(1-e));
N=a/sqrt(1-e*sin(B)^2);
% 2. aproximace
B=atan2((Z+N*e*sin(B)),sqrt(X^2+Y^2));
N=a/sqrt(1-e*sin(B)^2);
% 3. aproximace
FI=atan2((Z+N*e*sin(B)),sqrt(X^2+Y^2));
[F1]=deg2dms(FI/RAD);

alfa=1.000597498372; k=0.9965924869; R=6380703.6105;
FERRO=[17, 40, 0];[FERRO]=dms2deg(FERRO); FERRO=FERRO*RAD;
UK=[59,42,42.6969];[UK]=dms2deg(UK); UK=UK*RAD;
VK=[42,31,31.41725];[VK]=dms2deg(VK); VK=VK*RAD;
S0=[78,30,0];[S0]=dms2deg(S0); S0=S0*RAD;
m_koef=0.9999;

e=sqrt(e);
LAM=LAM+FERRO;
h=(1/k)*(tan(FI/2+pi/4)*((1-e*sin(FI))/(1+e*sin(FI)))^(e/2))^alfa;
U=2*(atan(h)-pi/4);
V=alfa*LAM;

S=asin(sin(UK)*sin(U)+cos(UK)*cos(U)*cos(VK-V));
D=asin((sin(VK-V)*cos(U))/cos(S));

ro0=R*cot(S0)*m_koef;
n=sin(S0);

ro=ro0*((tan(S0/2+pi/4)/tan(S/2+pi/4))^n);
eps=n*D;

m=(n*ro)/(R*cos(S));

X_JTSK=ro*cos(eps)
Y_JTSK=ro*sin(eps)

function [st]=dms2deg(v)
%převod stupňů, minut, vteřin na desetiné číslo
%vstup:
%   v-matice [s m v]
%vystup:
%   st-desetiné číslo
[r]=size(v,1);
st=ones(r,1);
for i=1:r
        if any(v(i,:)<0)
            Q=(-1);
        else
            Q=(1);
        end
        st(i,1)=(abs(v(i,1))+abs(v(i,2)/60)+abs(v(i,3)/3600))*Q;
end
end
