function [R]=valc_ster(LOXR,ORTR,R)
%% HELP
% Válcová stereografická projekce
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

%% Výpočet bodů
x=R*pol;
y=2*R*tan(rov/2);

x1=R*LOXR(2,:);
y1=2*R*tan(LOXR(1,:)/2);

x2=R*ORTR(2,:);
y2=2*R*tan(ORTR(1,:)/2);

%% tvorba sítě
[h, v] = meshgrid(y, x);

%% GRAF
figure(3);
plot(x,h,'k')
hold on
plot(v,y,'k')
graf_sit=plot(0,0,'k');
graf_lox=plot(x1,y1,'b');
graf_ort=plot(x2,y2,'r');
hold off

axis equal
title('Válcová stereografická projekce')
legend([graf_sit,graf_lox, graf_ort],'Kartografická síť','Loxodroma','Ortodroma','Location','southwest')
end
