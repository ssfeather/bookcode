%M02_06_fft_abs.m计算时间序列的DFT绝对值、
%按时间窗归一化的傅里叶谱振幅绝对值、
%傅里叶振幅谱密度绝对值
%傅里叶谱的真振幅

clearvars
%--使用持续的周期信号x(t)=3*sin(2*pi*t)+1.5*sin(2*pi*5*t)+2--------------------
inv         = 0.02;                             %采样频率
shoLen      = 1000;                             %短数据长度
shoSeq      = inv*(1:shoLen);
shoDat      = 4*sin(2*pi*shoSeq)+2*sin(2*pi*5*shoSeq)+2;   %???为什么不使用3*sin(2*pi*t)+1.5*sin(2*pi*5*t)+2???
lonLen      = 4000;                             %长数据长度
lonSeq      = inv*(1:lonLen);
lonDat      = 4*sin(2*pi*lonSeq)+2*sin(2*pi*5*lonSeq)+2;
%--绘制生成波形-------------------------
figure
%???按书中说前1000个点，后面4000个点，（1000+4000）× 0.02=100s，不应该是80s的时间长,第二章P20???

%长80s绘图
% plot(lonSeq(1:lonLen),lonDat(1:lonLen),'b')
% hold on
% plot(shoSeq(1:shoLen),shoDat(1:shoLen),'g')
% hold on
% plot([inv*shoLen,inv*shoLen],[max([shoDat,lonDat]),min([shoDat,lonDat])],'r')
%长100s绘图
plot(shoSeq(1:shoLen),shoDat(1:shoLen),'g')
hold on
plot(lonSeq(1:lonLen)+max(shoSeq),lonDat(1:lonLen),'b')
hold on
plot([inv*shoLen,inv*shoLen],[max([shoDat,lonDat]),min([shoDat,lonDat])],'r')
xlabel('t/s')
title('(a) test signal:x=4*sin(2*pi*t)+2*sin(2*pi*5*t)+2')

%------------------------------------
shoDf=1/(shoLen*inv);                   %???为什么横坐标这么计算???
shoF=shoDf*(1:shoLen)-shoDf;
lonDf=1/(lonLen*inv);
lonF=lonDf*(1:lonLen)-lonDf;

%--计算变换系数绝对值--------------------
shoFft=fft(shoDat);
shoDftAbs=abs(shoFft);
shoDftAbs(1)=shoDftAbs(1)/2;            %???为什么第一个值要取一半值???
lonFft=fft(lonDat);
lonDftAbs=abs(lonFft);
lonDftAbs(1)=lonDftAbs(1)/2;
%--计算谱振幅绝对值----------------------
shoFnAbs=abs(shoFft/shoLen);
shoFnAbs(1)=shoFnAbs(1)/2;              
lonFnAbs=abs(lonFft/lonLen);
lonFnAbs(1)=shoFnAbs(1)/2;
%--计算振幅谱密度绝对值-------------------
shofndAbs=abs(inv*shoFft);
shofndAbs(1)=shofndAbs(1)/2;
lonFndAbs=abs(inv*lonFft);
lonFndAbs(1)=lonFndAbs(1)/2;
%--计算谱真实振幅------------------------
shoReaAmp=2*abs(shoFft)/shoLen;
shoReaAmp(1)=shoReaAmp(1)/2;
lonReaAmp=2*abs(lonFft)/lonLen;
lonReaAmp(1)=lonReaAmp(1)/2;

%--绘制计算结果--------------------------
figure
subplot(421)
bar(shoF(1:shoLen),shoDftAbs(1:shoLen),2,'b')
axis([-1 shoDf*shoLen 0 10000])
title('(b) 变换系数绝对值','FontName','SimSun')
xlabel('f/Hz')

subplot(422)
bar(lonF(1:lonLen),lonDftAbs(1:lonLen),8,'b')
axis([-1 lonDf*lonLen 0 10000])
title('(b) 变换系数绝对值','FontName','SimSun')
xlabel('f/Hz')

subplot(423)
bar(shoF(1:shoLen),shoFnAbs(1:shoLen),2,'b')
axis([-1 shoDf*shoLen 0 4])
title('(c) 谱振幅绝对值','FontName','SimSun')
xlabel('f/Hz')

subplot(424)
bar(lonF(1:lonLen),lonFnAbs(1:lonLen),8,'b')
axis([-1 lonDf*lonLen 0 4])
title('(c) 谱振幅绝对值','FontName','SimSun')
xlabel('f/Hz')

subplot(425)
bar(shoF(1:shoLen),shofndAbs(1:shoLen),2,'b')
axis([-1 shoDf*shoLen 0 200])
title('(d) 振幅谱密度绝对值','FontName','SimSun')
xlabel('f/Hz')

subplot(426)
bar(lonF(1:lonLen),lonFndAbs(1:lonLen),8,'b')
axis([-1 lonDf*lonLen 0 200])
title('(d) 振幅谱密度绝对值','FontName','SimSun')
xlabel('f/Hz')

subplot(427)
bar(shoF(1:shoLen),shoReaAmp(1:shoLen),2,'b')
axis([-1 shoDf*shoLen 0 5])
title('(e) 谱真实振幅','FontName','SimSun')
xlabel('f/Hz')

subplot(428)
bar(lonF(1:lonLen),lonReaAmp(1:lonLen),8,'b')
axis([-1 lonDf*lonLen 0 5])
title('(e) 谱真实振幅','FontName','SimSun')
xlabel('f/Hz')

%--使用地震记录波形-----------------------------------------------------------
lonLen=16000;
shoLen=8000;
load M02_04_dalianE1.txt; % 读入一道波形数据
lonDat(1:lonLen)=M02_04_dalianE1(2501:lonLen+2500);
shoDat(1:shoLen)=M02_04_dalianE1(2501:shoLen+2500);
inv=0.02;
shoSeq=inv*(1:shoLen);
shoDf=1/(shoLen*inv);
shoF=shoDf*(1:shoLen)-shoDf;
shoFft=fft(shoDat);
shoDftAbs=abs(shoFft);
shoDftAbs(1)=shoDftAbs(1)/2;
shoFnAbs=abs(shoFft/shoLen);
shoFnAbs(1)=shoFnAbs(1)/2;
shofndAbs=abs(inv*shoFft);
shofndAbs(1)=shofndAbs(1)/2;
shoReaAmp=2*abs(shoFft)/shoLen;
shoReaAmp(1)=shoReaAmp(1)/2;
lonSeq=inv*(1:lonLen);
lonDf=1/(lonLen*inv);
lonF=lonDf*(1:lonLen)-lonDf;
%--------------------------------------------------------------------------
figure
plot(lonSeq(1:lonLen),lonDat(1:lonLen))
xlabel('t/s')
title('(a) test signal:x=M02-04-dalianE1(2501:N+2500)')
%--------------------------------------------------------------------------
figure
lonFft=fft(lonDat);
lonDftAbs=abs(lonFft);
lonDftAbs(1)=lonDftAbs(1)/2;
subplot(221)
bar(shoF(1:shoLen),shoDftAbs(1:shoLen),2)
%axis([-1 df*N 0 5000])
axis([-1 shoDf*shoLen 0 8000000])
title('(b) dft-abs')
xlabel('f/Hz')
%------------------------------------
subplot(222)
bar(lonF(1:lonLen),lonDftAbs(1:lonLen),2)
axis([-1 lonDf*lonLen 0 8000000])
title('(b) dft-abs')
xlabel('f/Hz')
%-------------------------------------
shoFnAbs=abs(lonFft/lonLen);
shoFnAbs(1)=shoFnAbs(1)/2;
subplot(223)
bar(shoF(1:shoLen),shoFnAbs(1:shoLen),2)
axis([-1 shoDf*shoLen 0 1200])
title('(c) fn-abs')
xlabel('f/Hz')
subplot(224)
bar(lonF(1:lonLen),shoFnAbs(1:lonLen),2)
axis([-1 lonDf*lonLen 0 1200])
title('(c) fn-abs')
xlabel('f/Hz')
%--------------------------------------------------------------------------
figure
lonFndAbs=abs(inv*lonFft);
lonFndAbs(1)=lonFndAbs(1)/2;
subplot(221)
bar(shoF(1:shoLen),shofndAbs(1:shoLen),2)
axis([-1 shoDf*shoLen 0 200000])
title('(d) fnd-abs')
xlabel('f/Hz')
subplot(222)
bar(lonF(1:lonLen),lonFndAbs(1:lonLen),2)
axis([-1 lonDf*lonLen 0 200000])
title('(d) fnd-abs')
xlabel('f/Hz')
lonReaAmp=2*abs(lonFft)/lonLen;
lonReaAmp(1)=lonReaAmp(1)/2;
subplot(223)
bar(shoF(1:shoLen),shoReaAmp(1:shoLen),2)
axis([-1 shoDf*shoLen 0 1500])
title('(e) An')
xlabel('f/Hz')
subplot(224)
bar(lonF(1:lonLen),lonReaAmp(1:lonLen),2)
axis([-1 lonDf*lonLen 0 1500])
title('(e) An')
xlabel('f/Hz')
