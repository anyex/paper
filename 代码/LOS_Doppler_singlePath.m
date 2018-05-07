function [ y ] = LOS_Doppler_singlePath( d,fc,v,startT,endT,deltaT )
%LOS_DOPPLER_SINGLEPATH 此处显示有关此函数的摘要
%fc：载波频率
%v：绝对速度
%startT,endT,信道仿真的开始时间，终止时间，通常startT=0,endT=1;

%   此处显示详细说明
numT = (endT-startT)/deltaT+1;
t = startT:deltaT:endT;
wc = 2*pi*fc;
c = 300*10^3;%光速
wm = wc*(v/c);%最大多普勒频移  
fm = wm/(2*pi);

sigma_u = sqrt(1/2);
alpha=atan(28/(d*1000));%方位角
wn=wm*cos(alpha);
lambda=c/fc;
phi=(2*pi*d*1000)/(lambda*cos(alpha));%第n条路径的附加相移
T=sigma_u*(cos(wn*t+phi)+j*sin(wn*t+phi));
y=T; 

end
