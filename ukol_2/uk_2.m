clc; clear; format long G
U=10; V=160;
RAD=pi/180;
U1=U*RAD; V1=V*RAD;
R=6380000;
cis=[R,U1,V1];
%% derivace
syms u
syms v
syms r
PROM=[r,u,v];
f=r*cot(u)*sin(v*sin(u));
g=r*(cot(u)*(1-cos(v*sin(u)))+u);
fu=diff(f,u); fv=diff(f,v);
gu=diff(g,u); gv=diff(g,v);
rov=[fu,fv,gu,gv];
A1=subs(rov,PROM,cis);
A1=eval(A1);

%%
F=R*cot(U1)*sin(V1*sin(U1));
G=R*(cot(U1)*(1-cos(V1*sin(U1)))+U1);

fu=A1(1); fv=A1(2); gu=A1(3); gv=A1(4);

mp=sqrt(A1(1)^2+A1(3)^2)/R;                                                               
mr=sqrt(A1(2)^2+A1(4)^2)/(R*cos(U1));                                           

p=(2*(fu*fv+gu*gv))/((R^2)*cos(U1));
Ae1=(atan(p/(mp^2-mr^2)))/2/RAD;
Ae2=Ae1+pi/2/RAD;
                
v=atan((fv*gu-fu*gv)/(fu*fv+gu*gv))/RAD;

a=sqrt((((fu^2+gu^2)/R^2)*(cos(Ae1*RAD))^2)+(((fv^2+gv^2)/((R^2)*(cos(U1))^2))*(sin(Ae1*RAD))^2)+(((2*(fu*fv+gu*gv))/((R^2)*cos(U1)))*sin(Ae1*RAD)*cos(Ae1*RAD)));
b=sqrt((((fu^2+gu^2)/R^2)*(cos(Ae2*RAD))^2)+(((fv^2+gv^2)/((R^2)*(cos(U1))^2))*(sin(Ae2*RAD))^2)+(((2*(fu*fv+gu*gv))/((R^2)*cos(U1)))*sin(Ae2*RAD)*cos(Ae2*RAD)));

wd=asin(abs(b-a)/(b+a))*2/RAD;                                                  

Ace1=atan((b/a)*tan(Ae1*RAD))/RAD;  
Ace2=(atan((b/a)*tan(Ae2*RAD-Ae1*RAD))+Ace1*RAD)/RAD;                                                                   

P=(fv*gu-fu*gv)/(R*R*cos(U1));                                                 

[body] = elispa(F,G,a,b,fu,gu,Ace1);
[R] = geogsit(R,body,F,G);

vysledky=[v,Ae1,Ae2,Ace1,Ace2,wd];
[vysledky]=deg2dms(vysledky);
vysledky(3,:)=round(vysledky(3,:));
mp=round(mp,6);mr=round(mr,6);a=round(a,6);b=round(b,6);P=round(P,6);

%%
function [body] = elispa(U,V,a,b,fu,gu,Ace1)
RAD=pi/180; a=a*2500000; b=b*2500000;
D=atan2(gu,fu)/RAD; E=(D+Ace1)*RAD; stoc=[cos(E),-sin(E); sin(E), cos(E)];
t=linspace(0,2*pi,1000);
body(1,:)=cos(t)*a;
body(2,:)=sin(t)*b;
body=stoc*body;
body(1,:)=(body(1,:))+U;
body(2,:)=(body(2,:))+V;
end
%%
function [R] = geogsit(R,ELP,U,V)
%% Generování sítě
RAD=pi/180;
rov=(90:-10:-90)*RAD;
pol=(-180:10:180)*RAD;
%% Kresba sítě
for n=1:length(rov)
    for m=1:length(pol)
        if rov(n)~=0
            x(n,m)=R*cot(rov(n))*sin(pol(m)*sin(rov(n)));
            y(n,m)=R*(cot(rov(n))*(1-cos(pol(m)*sin(rov(n))))+rov(n));
        else
            x(n,m)=pol(m)*R;
            y(n,m)=rov(n);
        end
        plot(x(:,m),y(:,m),'k')
        hold on
    end
    plot(x(n,:),y(n,:),'k')
    hold on
end

graf_sit=plot(0,0,'k');
graf_el=plot(ELP(1,:),ELP(2,:),"Color",'b');
graf_ob=plot([U,ELP(1,1)],[V,ELP(2,1)],"Color",'g');
graf_oa=plot([U,ELP(1,1*(length(ELP)/4*3))],[V,ELP(2,1*(length(ELP)/4*3))],"Color",'r');
axis equal
xlabel('X[m]');
ylabel('Y[m]');
title('Hasslerovo (americké polykonické) zobrazení')
legend([graf_sit,graf_el, graf_oa,graf_ob],'Kartografická síť','Tissotova indikatrix','Poloosa a','Poloosa b','Location','southwest')
end
