%% 向下重采样
%       orgInv    : 原采样间隔（每秒100点）
%       newInv    : 新采样间隔（每秒50点）
%       orgDatLen : 原数据点数
%       newDatLen : 新数据点数
%       orgFs     : 原采样率
%       newFs     : 新采样率
%       orgCutFre : 原截止频率=1/2采样率
%       ratio     : 新采样间隔/原采样间隔
%       zeta      : 重采样的低通滤波器参数
clearvars

orgInv      = 0.01;                           
newInv      = 0.02;                            
orgDatLen   = 4096;                            
newDatLen   = floor(orgDatLen*orgInv/newInv); 
orgFs       = 1/orgInv;                       
newFs       = 1/newInv;                    
orgCutFre   = orgFs/2;                       
ratio       = newInv/orgInv;                 
zeta        = newFs/(2*orgCutFre);            

%% 生成采样率为1000和100的波形

t1000=0:0.001:orgDatLen*orgInv-1;
mix1000=sin(2*pi*1*(t1000+1-orgInv))+0.5*sin(2*pi*30*(t1000+1-orgInv));
t100=(0:orgDatLen-1)/orgFs;
mix100=sin(2*pi*1*t100)+0.5*sin(2*pi*30*t100);
%% 向下采样为50采样率

% Sinc是一个滤波器，它除去给定带宽之上的信号分量而只保留低频信号的理想电子滤波器。
% 理想的Sinc滤波器（矩形滤波器）,有无限的延迟，现实世界中的滤波器只能是它的一个近似。
comSta = floor(orgFs/ratio)+orgFs+1;
comEnd = newDatLen-floor(orgFs/ratio)-1;
difDat = zeros(1,comEnd);                     %初始化重采样序列
for m=comSta:comEnd
    for n=floor(m*ratio)-orgFs:1:floor(m*ratio)+orgFs
        difDat(m)=difDat(m)+zeta*mix100(n)*sinc(zeta*(m*ratio-n));
    end
end
t50=(0:newDatLen-1)/newFs;

%% 绘图---------------------------------------------------------------------
figure;
plot(t1000,mix1000,'g')
hold on
plot(t100(1+1:orgDatLen-orgFs),mix100(1+orgFs:orgDatLen-1),'r');
hold on
%???为什么乘重采样的低通滤波器参数（zeta）???
%plot(tt1(floor(Fs0/ratio)+Fs0+1-Fs1+1:N1-floor(Fs0/ratio)-1-Fs1+1),x(floor(Fs0/ratio)+Fs0+1:N1-floor(Fs0/ratio)-1)*zeta,'b');
%hold on
plot(t50(orgFs+1:newDatLen-2*newFs),difDat(newFs+orgFs:newDatLen-newFs-1),'b');
hold on
xlabel('时间/s')
%% 计算不同采样率波形频谱

fft100=abs(fft(mix100,orgDatLen));
f=(0:(orgDatLen-1))*orgFs/orgDatLen;
%----------------------------------
%???为什么使用32768（4096×8)???
fft1000=abs(fft(mix1000,32768));
fz=(0:(32768-1))/(32768*0.001);
%----------------------------------
Nx=length(difDat);
xn1=sin(2*pi*1*t50)+0.5*sin(2*pi*30*t50);
fft50=abs(fft(xn1));
fxn1=((0:newDatLen-1))*newFs/newDatLen;

%% 绘图---------------------------------------------------------------------
figure;
subplot(4,1,1);
plot(f,fft100*2/orgDatLen);
title('(a) 100sps    采样的频谱')
subplot(4,1,2);
plot(fz,2*fft1000/32768);
title('(b) 1000sps   采样的频谱');
subplot(4,1,3);
plot(fxn1,fft50*2/Nx);
title('(c) 50sps 采样未滤波频谱');
subplot(4,1,4)
xfft=abs(fft(difDat));  
fx=(0:Nx-1)*newFs/Nx;
plot(fx,2*xfft/Nx);
title('(d) 50sps采样(在重采样的同时已实现了低通滤波)');
xlabel('频率/Hz');
%% 用样条函数（spline)模拟信号恢复

ty1=0:0.001:orgDatLen*orgInv;
n=0:orgDatLen-1;
xa=spline(n*orgInv,mix100,ty1);

%% 绘图---------------------------------------------------------------------
figure;
subplot(2,1,1)
plot(t100(1:100),mix100(1:100));
title('x=sin(2*pi*1*t)+0.5*sin(2*pi*30*t),采样率100sps');
subplot(2,1,2)
plot(ty1(1:1000),xa(1:1000))
title('用样条函数插值由x恢复xa');
xlabel('时间/s','FontName','SimSun');
