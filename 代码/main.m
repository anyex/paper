clear all
clc
d=10000;  %通信距离
fc=900000000; %载波频率
v=10;  %移动速度 [m/s]
startT=0;
endT=5;
deltaT=1/10000;
t=startT:deltaT:endT;
wc=2*pi*fc;
c=3*10^8; %光速
wm=wc*(v/c); %最大多普勒相移
fm=wm/(2*pi); %最大多普勒频移
delayTime=[0,310,710,1090,1730,2510]; %频率选择性多径模型的相关延迟时间[ns]
averagePower=[0,-1,-9,-10,-15,-20];%频率选择性多径模型的平均功耗[dB]
averagePower=10.^(averagePower/10); %功率转换单位
averagePower=averagePower/sum(averagePower);
Np=length(delayTime);
for n=1:1:Np;
lenT(n)=length(startT+delayTime(n)*10^-6:deltaT:endT);
end
R0=zeros(Np,min(lenT));
R1=sqrt(averagePower(1))*LOS_Doppler_singlePath(d,fc,v,startT+delayTime(1)*10^-6,endT,deltaT);%叠加LOS多普勒单径信道模型
R0(1,1:min(lenT))=R1(1,1:min(lenT));
for n=2:1:Np
tempr=sqrt(averagePower(n))*Rayleigh_Doppler_singlePath(fc,v,startT+delayTime(n)*10^-6,endT,deltaT);%叠加瑞利多普勒单径信道模型
R0(n,:)=tempr(1:min(lenT));
clear tempr;
end
R_LOS=(20000*R0(1,:)).*Pathloss(2140,d,0,2); %LOS多普勒单径信道叠加路径损耗(包括阴影衰落)模型，具体见Pathloss函数描述
R_NLOS=(20000*sum(R0(2:Np,:))).*Pathloss(2140,d,0,2); %多径瑞利衰落信道叠加路径损耗(包括阴影衰落)模型，具体见Pathloss函数描述
% %+++++++++++++++++++++++++++++++++++
R=R_NLOS+R_LOS; %无线信道（LOS+多径瑞利衰落+损耗+阴影衰落）
R=awgn(R,20);
%
% %+++++++++++++++++++++++++++++++++++
figure(1);
plot(t(1:min(lenT)),10*log10(R));
xlim([0 0.05])
title('无线信道（LOS+多径瑞利衰落+损耗+阴影衰落）d=10Km v=10m/s,fc=900MHZ');
ylabel('接收信号强度[dBm]');
xlabel('时间[ms]');
grid on
%+++++++++++++++++++++++++++++++++++
%+++++++++++++++++++++++++++++++++++
