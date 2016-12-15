%M02_06_fft_abs.m计算时间序列的DFT绝对值、
%按时间窗归一化的傅里叶谱振幅绝对值、
%傅里叶振幅谱密度绝对值
%傅里叶谱的真振幅
%第一类信号：持续的周期信号
%x(t)=3*sin(2*pi*t)+1.5*sin(2*pi*5*t)+2
%dt=0.01s,N=1024,t=dt*(1:N)
clearvars
inv=0.02;
shoLen=1000;
shoSeq=inv*(1:shoLen);
shoDat=4*sin(2*pi*shoSeq)+2*sin(2*pi*5*shoSeq)+2;
lonLen=4000;
lonSeq=inv*(1:lonLen);
lonDat=4*sin(2*pi*lonSeq)+2*sin(2*pi*5*lonSeq)+2;

figure
plot(lonSeq(1:lonLen),lonDat(1:lonLen))
hold on
plot([20,20],[8,-4],'r')
xlabel('t/s')
title('(a) test signal:x=4*sin(2*pi*t)+2*sin(2*pi*5*t)+2')
%--------------------------------------------------------------------------
shoFft=fft(shoDat);
dftAbs=abs(shoFft);
dftAbs(1)=dftAbs(1)/2;
fnAbs=abs(shoFft/shoLen);
fnAbs(1)=fnAbs(1)/2;
fndAbs=abs(inv*shoFft);
fndAbs(1)=fndAbs(1)/2;
an=2*abs(shoFft)/shoLen;
an(1)=an(1)/2;

df=1/(shoLen*inv);
f=df*(1:shoLen)-df;
df1=1/(lonLen*inv);
f1=df1*(1:lonLen)-df1;

%--------------------------------------------------------------------------

figure
y1=fft(lonDat);
dft_abs1=abs(y1);
dft_abs1(1)=dft_abs1(1)/2;
subplot(221)
bar(f(1:shoLen),dftAbs(1:shoLen),0.2)
axis([-1 df*shoLen 0 10000])
title('(b) dft-abs')
xlabel('f/Hz')
%------------------------------------
subplot(222)
bar(f1(1:lonLen),dft_abs1(1:lonLen),0.2)
axis([-1 df1*lonLen 0 10000])
title('(b) dft-abs')
xlabel('f/Hz')
%-------------------------------------
fn_abs1=abs(y1/lonLen);
fn_abs1(1)=fn_abs1(1)/2;
subplot(223)
bar(f(1:shoLen),fnAbs(1:shoLen),0.2)
axis([-1 df*shoLen 0 4])
title('(c) fn-abs')
xlabel('f/Hz')
subplot(224)
bar(f1(1:lonLen),fn_abs1(1:lonLen),0.2)
axis([-1 df1*lonLen 0 4])
title('(c) fn-abs')
xlabel('f/Hz')
%--------------------------------------------------------------------------
figure
fnd_abs1=abs(inv*y1);
fnd_abs1(1)=fnd_abs1(1)/2;
subplot(221)
bar(f(1:shoLen),fndAbs(1:shoLen),0.2)
axis([-1 df*shoLen 0 200])
title('(d) fnd-abs')
xlabel('f/Hz')
subplot(222)
bar(f1(1:lonLen),fnd_abs1(1:lonLen),0.2)
axis([-1 df1*lonLen 0 200])
title('(d) fnd-abs')
xlabel('f/Hz')
an1=2*abs(y1)/lonLen;
an1(1)=an1(1)/2;
subplot(223)
bar(f(1:shoLen),an(1:shoLen),0.2)
axis([-1 df*shoLen 0 5])
title('(e) An')
xlabel('f/Hz')
subplot(224)
bar(f1(1:lonLen),an1(1:lonLen),0.2)
axis([-1 df1*lonLen 0 5])
title('(e) An')
xlabel('f/Hz')
%--------------------------------------------------------------------------
%使用地震记录波形
lonLen=16000;
shoLen=8000;
load M02_04_dalianE1.txt; % 读入一道波形数据
lonDat(1:lonLen)=M02_04_dalianE1(2501:lonLen+2500);
shoDat(1:shoLen)=M02_04_dalianE1(2501:shoLen+2500);
inv=0.02;
shoSeq=inv*(1:shoLen);
df=1/(shoLen*inv);
f=df*(1:shoLen)-df;
shoFft=fft(shoDat);
dftAbs=abs(shoFft);
dftAbs(1)=dftAbs(1)/2;
fnAbs=abs(shoFft/shoLen);
fnAbs(1)=fnAbs(1)/2;
fndAbs=abs(inv*shoFft);
fndAbs(1)=fndAbs(1)/2;
an=2*abs(shoFft)/shoLen;
an(1)=an(1)/2;
lonSeq=inv*(1:lonLen);
df1=1/(lonLen*inv);
f1=df1*(1:lonLen)-df1;
%--------------------------------------------------------------------------
figure
plot(lonSeq(1:lonLen),lonDat(1:lonLen))
xlabel('t/s')
title('(a) test signal:x=M02-04-dalianE1(2501:N+2500)')
%--------------------------------------------------------------------------
figure
y1=fft(lonDat);
dft_abs1=abs(y1);
dft_abs1(1)=dft_abs1(1)/2;
subplot(221)
bar(f(1:shoLen),dftAbs(1:shoLen),0.2)
%axis([-1 df*N 0 5000])
axis([-1 df*shoLen 0 8000000])
title('(b) dft-abs')
xlabel('f/Hz')
%------------------------------------
subplot(222)
bar(f1(1:lonLen),dft_abs1(1:lonLen),0.2)
axis([-1 df1*lonLen 0 8000000])
title('(b) dft-abs')
xlabel('f/Hz')
%-------------------------------------
fn_abs1=abs(y1/lonLen);
fn_abs1(1)=fn_abs1(1)/2;
subplot(223)
bar(f(1:shoLen),fnAbs(1:shoLen),0.2)
axis([-1 df*shoLen 0 1200])
title('(c) fn-abs')
xlabel('f/Hz')
subplot(224)
bar(f1(1:lonLen),fn_abs1(1:lonLen),0.2)
axis([-1 df1*lonLen 0 1200])
title('(c) fn-abs')
xlabel('f/Hz')
%--------------------------------------------------------------------------
figure
fnd_abs1=abs(inv*y1);
fnd_abs1(1)=fnd_abs1(1)/2;
subplot(221)
bar(f(1:shoLen),fndAbs(1:shoLen),0.2)
axis([-1 df*shoLen 0 200000])
title('(d) fnd-abs')
xlabel('f/Hz')
subplot(222)
bar(f1(1:lonLen),fnd_abs1(1:lonLen),0.2)
axis([-1 df1*lonLen 0 200000])
title('(d) fnd-abs')
xlabel('f/Hz')
an1=2*abs(y1)/lonLen;
an1(1)=an1(1)/2;
subplot(223)
bar(f(1:shoLen),an(1:shoLen),0.2)
axis([-1 df*shoLen 0 1500])
title('(e) An')
xlabel('f/Hz')
subplot(224)
bar(f1(1:lonLen),an1(1:lonLen),0.2)
axis([-1 df1*lonLen 0 1500])
title('(e) An')
xlabel('f/Hz')
