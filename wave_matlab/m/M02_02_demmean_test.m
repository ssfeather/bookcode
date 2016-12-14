%试验去滑动平均2013-01-28
clear;
load M02_02_dalianN1.dat;
m=length(M02_02_dalianN1)
x_n=M02_02_dalianN1(1:30000);
for i=1:m
    x(i)=x_n(i)+20000*sin(2*pi*i/5000);
end
figure(1);
title('原始波形，人为加上低频正弦波噪声')
plot(x);

M=200
[y,m]=M02_02_demmean_func(x,M);
figure(2);
plot(y);
title('去滑动平均结果，去掉了低频正弦波噪声')
figure(3);
plot(m);
p=2*M+1;
title({'滑动平均，结果只包含低频噪声，滑动窗长2M+1=',p});

figure(4)
%绘出信号的频谱
L=length(x)
Fs=50 %采样率
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(x,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);
%绘信号的振幅谱
% Plot single-sided amplitude spectrum.
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('原始带低频正弦波噪声的信号振幅谱')
xlabel('频率/Hz')
ylabel('|Y(f)|')

figure(5)
%绘出去滑动平均后的频谱
L=length(x)
Fs=50 %采样率
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
plot(f,2*abs(Y(1:NFFT/2+1))) 
title('去掉低频噪声后的振幅谱')
xlabel('频率/Hz')
ylabel('|Y(f)|')
