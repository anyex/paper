function y=Pathloss(fc,d,flag_PL,sigmal1)
Heff=30; %基站天线的有效高度
Hms=2; %移动台高度
diffn=0;
C_loss=0;
k1=160.43; %截距
k2=38.72;%斜率
k3=0;%移动台天线的高度因子
k4=0;%移动台天线高度 Okumura-Hata 增值系数
k5=-13.82;%基站天线有效高度增益
k6=-6.55;%lg（Heff）lg（d）的 Okumura-Hata 增值系数
k7=0;%衍射计算的增值系数
%sigma11=3; %阴影衰落的标准差
if flag_PL==0 %当flag=0 使用 COST231-Hata 损耗模型（通用仿真模型代替）
    PL1=k1+k2*log10(d)+k3*Hms+k4*log10(Hms)+k5*log10(Heff)+k6*log10(Heff)*log10(d)+k7*diffn+C_loss;
    yinying=10*log10(lognrnd(0,sigmal1));%阴影衰落服从对数正太分布
    PL=PL1+yinying;
elseif flag_PL==1 %当flag=1使用自由空间损耗模型
    PL1=32.45+20*log10(d)+20*log10(fc);
    yinying=10*log10(lognrnd(0,sigmal1));%阴影衰落服从对数正太分布
    PL=PL1+yinying;
end
y=10^((-1)*PL/10);
end

