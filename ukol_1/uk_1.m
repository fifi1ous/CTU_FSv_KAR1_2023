clc; clear; format long G
%% Nastavení
U1=20;	V1=10;  U2=60;	V2=110;
RAS=pi/180;
int=10;
VO=V1:int:V2;
R=6380;
%% Ortodroma
V0=VO*RAS;  U0=U1*RAS; UK=U2*RAS; UP=U0; VP=V1*RAS; VK=V2*RAS; Ul=U0;
OrDel=acos(cos(pi/2-U0)*cos(pi/2-UK)+sin(pi/2-U0)*sin(pi/2-UK)*cos(VK-VP));
A=asin(sin(pi/2-UK)*sin(VK-VP)/sin(OrDel));
for n=1:length(VO)-1
    An(n)=acos(-cos(A)*cos(V0(n+1)-VP)+sin(A)*sin(V0(n+1)-VP)*cos(pi/2-UP));
    U0(n+1)=pi/2-asin(sin(A)*sin(pi/2-UP)/sin(An(n)));
end
delORT=round(OrDel*R,6);
[v]=deg2dms(U0/RAS);
ORTS=[v;VO]; ORTR=[U0;V0];
%% Loxodroma
AL=atan((VK-VP)/(log(tan(UK/2+pi/4))-log(tan(UP/2+pi/4))));
delLOX=round((R/cos(AL))*(UK-UP),6); 
for n=1:length(VO)-1
    Ul(n+1)=2*atan(tan(Ul(n)/2+pi/4)*exp(1)^((V0(n+1)-V0(n))/tan(AL)))-pi/2;
end
[v]=deg2dms(Ul/RAS);
LOXS=[v;VO]; LOXR=[Ul;V0];

%% Mercatorovo zobrazení
hr=86;
[R]=mercator2(LOXR,ORTR,hr,R);
%% Azimutální gnómická projekce
[R]=Azim_gnom(LOXR,ORTR,R);
%% Válcové steregrafická projekce
[R]=valc_ster(LOXR,ORTR,R);
%% Mercator-Sansonovo nepravé válcové sinuoidální zobrazení
[R]=merc_sans(LOXR,ORTR,R);