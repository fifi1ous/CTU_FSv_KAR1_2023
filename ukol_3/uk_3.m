clc; clear; format long G
RAD=pi/180;
R=6380000;

%% Válcové

poc=[20.23187,97.181719];
SS=[20.762419,105.394323
    20.545822,101.281141
    20.400835,99.228233
    20.319319,98.203994
    20.276332,97.692589];
for n=1:5
    stran(n,1)=acosd(cosd(90-poc(1))*cosd(90-SS(n,1))+sind(90-poc(1))*sind((90-SS(n,1)))*cosd(SS(n,2)-poc(2)));
    ms(n,1)=(2*cosd(stran(n,1)))/(1+cosd(stran(n,1)));
    du(n,1)=SS(n,1)-poc(1);
    dv(n,1)=SS(n,2)-poc(2);
    S0(n,1)=acosd(ms(n,1));
    mk(n,1)=2-ms(n,1);
end

A=1:5;mk=[A',mk];ms=[A',ms];stran=[A',stran];S0=[A',S0];d=[A',du,dv];
r=find(ms(:,2)<=1.0002);

% %% Azimutální
% str=[0, 0];
% kr=[10,10];
% del=acosd(cosd(90-str(1))*cosd(90-kr(1))+sind(90-str(1))*sind((90-kr(1)))*cosd(kr(2)-str(2)));
% ms1=(2*(cosd(del/2)^2)/(1+cosd(del/2)^2));
% mk1=ms1/(cosd(del/2)^2);
% %% nebyla splněna podmínka
% a=2*acosd(sqrt((2-1.0002)/1.0002));
% r=2*R*tand(a/2)*1.0002
