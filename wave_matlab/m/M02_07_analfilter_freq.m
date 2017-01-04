%M02_07_analfilter_freq.m
%利用模拟滤波器在频率域进行滤波
%滤波器示例：二阶高通巴特沃斯滤波器
%截止频率为1Hz。
clearvars
N       = 2;                             % 二阶
Wc      = 1*2*pi;                        % 截止频率1Hz
fc      = Wc/(2*pi);
[z,p,k] = butter(N,Wc,'high','s');
[b,a]   = zp2tf(z,p,k);
[h,w]   = freqs(b,a);
wl      = length(w);
figure
subplot(2,1,1)
plot(w/(2*pi),abs(h),'b');
hold on
axis([0 15 0 1.1])
ylabel('归一化振幅')
grid on
xlabel('频率/Hz')
subplot(2,1,2)
plot(w/(2*pi),unwrap(angle(h))*180/pi,'b');
hold on
axis([0 15 -1000 1000])
grid on
ylabel('相位/°')
xlabel('频率/Hz')

%-------------------------------------------------------
% 读入示例地震波形：巴楚地震台CTS-1垂直向记录M7.72013年4月16日伊朗-巴基斯坦交界地震
%XX_BCH_BHZ_2.txt
wavDat      = load('XX_BCH_BHZ_2.txt');
Fs          = 100;
n1          = 60000;
n2          = 0;
t1          = (1:n1)/Fs;
wave1(1:n1) = wavDat(n2+1:n2+n1);
fft_wave1   = fft(wave1);
w_wave1     = (1:n1)*2*pi*Fs/n1;
f_wave1     = w_wave1/(2*pi);
h_wave1     = freqs(b,a,w_wave1);
h1_wave1    = zeros(1,n1);
%构建与傅里叶变换得到的前段与后端共轭形式数据对应的滤波器
%万永革，2012，第429页）
for ii=1:n1/2
    h1_wave1(ii)=h_wave1(ii);
    h1_wave1(n1-ii+1)=conj(h1_wave1(ii));
end

%----频率域滤波
fft_ywave1 = zeros(1,n1);
for i=1:n1
    fft_ywave1(i)=fft_wave1(i)*h1_wave1(i);
end
ywave1=real(ifft(fft_ywave1));

scrsz = get(groot,'ScreenSize');
figure('Position',[scrsz(3)/3 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
subplot(2,2,1)
plot(t1,wave1)
xlabel('时间/s')
ylabel('count')

subplot(2,2,3)
plot(t1,ywave1)
xlabel('时间/s')
ylabel('count')

subplot(2,2,2)
loglog(f_wave1(1:n1/2),abs(fft_wave1(1:n1/2)))
title('滤波前')
xlabel('频率/Hz')
ylabel('谱振幅')

subplot(2,2,4)
loglog(f_wave1(1:n1/2),abs(fft_ywave1(1:n1/2)))
title('滤波后')
xlabel('频率/Hz')
ylabel('谱振幅')

