function [R]=mercator2(LOXR,ORTR,hr,R)
%% HELP
% Výpočet a grafická ukázka válcového konformního zobrazení s jednou
% nezkreslenou rovnoběžkou (Mercatorovo)
% VSTUP :
%          LOXR = matice souřadnic loxodromy v radiánech
%          ORTR = matice souřadnic ortodromy v radiánech
%            hr = krajní souřadnice rovnoběžek ve stupních
%             R = poloměr Země
% Výstup:
%          Graf zobrazení a vykreslené geodetické křivky
 
%% Nastavení sítě
pol=-180:10:180;
rov=80:-10:-80;

rov=[hr, rov, -hr];

pol=pol*pi/180;
rov=rov*pi/180;

%% Výpočet bodů
x=R*pol;
y=R*log(tan(rov/2+pi/4));

x1=R*LOXR(2,:);
y1=R*log(tan(LOXR(1,:)/2+pi/4));

x2=R*ORTR(2,:);
y2=R*log(tan(ORTR(1,:)/2+pi/4));

%% tvorba sítě
[h, v] = meshgrid(y, x);

%% GRAF
figure(1);
plot(x,h,'k')
hold on
plot(v,y,'k')
graf_sit=plot(0,0,'k');
graf_lox=plot(x1,y1,'b');
graf_ort=plot(x2,y2,'r');
hold off

axis equal
title('Mercatorovo konformní válcové zobrazení')
legend([graf_sit,graf_lox, graf_ort],'Kartografická síť','Loxodroma','Ortodroma')
end
