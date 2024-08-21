function [R]=merc_sans(LOXR,ORTR,R)
%% HELP
% Mercator-Sansonovo nepravé válcové sinusoidální zobrazení
% VSTUP :
%          LOXR = matice souřadnic loxodromy v radiánech
%          ORTR = matice souřadnic ortodromy v radiánech
%             R = poloměr Země
% Výstup:
%          Graf zobrazení a vykreslené geodetické křivky
 
%% Nastavení sítě
pol=-180:10:180;
rov=90:-10:-90;

pol=pol*pi/180;
rov=rov*pi/180;
d=0;
%% Tvorba sítě
figure(4);
for n=1:size(rov,2)
    for m=1:size(pol,2)
        x(n,m)=R*pol(m)*cos(rov(n));
        y(n,m)=R*rov(n);
    plot(x(:,m),y(:,m),'k')
    hold on
    end
    plot(x(n,:),y(n,:),'k')
    hold on
end
%% Výpočet bodů
x1=R*LOXR(2,:).*cos(LOXR(1,:));
y1=R*LOXR(1,:);

x2=R*ORTR(2,:).*cos(ORTR(1,:));
y2=R*ORTR(1,:);

%% GRAF
hold off
hold on
graf_sit=plot(0,0,'k');
graf_lox=plot(x1,y1,'b');
graf_ort=plot(x2,y2,'r');
hold off

axis equal
title('Mercator-Sansonovo nepravé válcové sinusoidální zobrazení')
legend([graf_sit,graf_lox, graf_ort],'Kartografická síť','Loxodroma','Ortodroma')
end
