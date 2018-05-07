function [ y ] = Rayleigh_Doppler_singlePath( fc,v,startT,endT,deltaT )
%RAYLEIGH_DOPPLER_SINGLEPATH 此处显示有关此函数的摘要
%fc：载波频率
%v：绝对速度
%startT,endT,信道仿真的开始时间，终止时间，通常startT=0,endT=1;
%   此处显示详细说明
%numT = (endT-startT)/deltaT+1;
t=startT:deltaT:endT;
wc=2*pi*fc;%载波
c=300*10^3;%光速
wm=wc*(v/c);%最大多普勒频移
fm=wm/(2*pi);
N0=100;%入射波数目
N=4*N0;
sigma_u=sqrt(1/2);%归一化功率系数
Tc=zeros(1,length(startT:deltaT:endT));
Ts=zeros(1,length(startT:deltaT:endT));
T=zeros(1,length(startT:deltaT:endT));

%b,c,d都是在[-0.5,0.5)区间的1行的随机矩阵
b=rand(1,1)-0.5*ones(1,1);
c=rand(1,length(startT:deltaT:endT))-0.5*ones(1,length(startT:deltaT:endT));
d=rand(1,length(startT:deltaT:endT))-0.5*ones(1,length(startT:deltaT:endT));

theta=2*pi*b;%产生一条随机路径

%每个子载波的随机相位
phi=2*pi*c;
ipsi=2*pi*d;

for i=1:N0
    alpha(i)=((2*i-1)*pi+theta)/N;%第i条入射波的入射角
    wn(i)=wm*cos(alpha(i));%第n条路径的多普勒频移
    Tc=Tc+(2*cos(wn(i)*t+phi(i))*cos(ipsi(i)));
    Ts=Ts+(2*cos(wn(i)*t+phi(i))*sin(ipsi(i)));
    
end
  T=(sigma_u*(1/N0^0.5)).*(Tc+j*Ts);%得到基带信号
 
  y=T(:);
end
