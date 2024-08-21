function [R]=Azim_gnom(LOXR,ORTR,R)
%% HELP
% Azimutální gnómická projekce
% VSTUP :
%          LOXR = matice souřadnic loxodromy v radiánech
%          ORTR = matice souřadnic ortodromy v radiánech  
%             R = poloměr Země
% Výstup:
%          Graf zobrazení a vykreslené geodetické křivky
 
%% Nastavení sítě
pol=-180:10:180;
rov=90:-10:10;

pol=pol*pi/180;
rov=rov*pi/180;

%% Tvorba sítě
figure(2);
for n=1:size(rov,2)
    for m=1:size(pol,2)
        x(n,m)=R*tan(pi/2-rov(n)).*cos(pol(m));
        y(n,m)=R*tan(pi/2-rov(n)).*sin(pol(m));
        plot(x(n,:),y(n,:),'k')
        hold on
    end
end
%% Výpočet bodů

x1=R*tan(pi/2-LOXR(1,:)).*cos(LOXR(2,:));
y1=R*tan(pi/2-LOXR(1,:)).*sin(LOXR(2,:));

x2=R*tan(pi/2-ORTR(1,:)).*cos(ORTR(2,:));
y2=R*tan(pi/2-ORTR(1,:)).*sin(ORTR(2,:));

%% GRAF
graf_sit=plot(0,0,'k');
graf_lox=plot(x1,y1,'b');
graf_ort=plot(x2,y2,'r');
hold off

title('Azimutální gnómická projekce')

axis equal
legend('Kartografická síť','Loxodroma','Ortodorma','Location','best')
legend([graf_sit,graf_lox, graf_ort],'Kartografická síť','Loxodroma','Ortodroma')
end
