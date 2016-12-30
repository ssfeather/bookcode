%M02_07_analfilter_time.m
% 读入示例地震波形：巴楚地震台CTS-1垂直向记录M7.72013年4月16日伊朗-巴基斯坦交界地震
%XX_BCH_BHZ_2.txt
clear all
starttime=clock
load XX_BCH_BHZ_2.txt
wave=XX_BCH_BHZ_2;
wavelen=length(wave)
n1=6000
n2=4000
n2=0
n1=60000
wave1([1:n1])=wave([n2+1:n2+n1]);
Fs=100
t1=([1:n1])/Fs;
figure(1)
plot(t1,wave1)
xlabel('时间/s')
ylabel('count')
%利用模拟滤波器在时间域进行滤波
%滤波器示例：二阶高通巴特沃斯滤波器
%截止频率为1Hz。
%M02_07_butter_design
N=2   %二阶
Wc=1*2*pi %截止频率1Hz
fc=Wc/(2*pi)
[z,p,k]=butter(N,Wc,'high','s')
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a);
w;
wl=length(w)
figure(2)
subplot(2,1,1)
%semilogx(w/(2*pi),abs(h),'b');hold on   %幅频响应
plot(w/(2*pi),abs(h),'b');hold on
%plot(w,abs(h),co);hold on
axis([0 15 0 1.1])
ylabel('归一化振幅')
grid on
xlabel('频率/Hz')
%axis([0 1 0 1.1])
%set(gca,'YTick',0:0.1:1.1)
subplot(2,1,2)
%semilogx(w/(2*pi),unwrap(angle(h))*180/pi,'b');hold on
plot(w/(2*pi),unwrap(angle(h))*180/pi,'b');hold on
axis([0 15 -1000 1000])
grid on
ylabel('相位/°')
xlabel('频率/Hz')
%-------------------------------------------------------
%构建与傅里叶变换得到的前段与后端共轭形式数据对应的滤波器
%万永革，2012，第429页）
%构造脉冲响应
w_wave1=([1:n1])*2*pi*Fs/n1;
f_wave1=w_wave1/(2*pi);
h_wave1=freqs(b,a,w_wave1);
h1=zeros(1,n1);
for ii=1:n1/2
    h1(ii)=h_wave1(ii);
    h1(n1-ii)=conj(h_wave1(ii));
end
impule=ifft(h1);
figure(3)
plot(t1(1:n1/2),impule(1:n1/2))   %脉冲响应
title('脉冲响应，采样率=100sps')
xlabel('时间/s')
%axis([0 100 0 1.1])
%-------------------------------------------------------
%时间域滤波
%式（2.71）
%n_impule=300*Fs  %脉冲响应长度
n_impule=2*Fs
for i=1:n1
    ywave1(i)=0;
   if i<n_impule+1
       for j=1:i
        ywave1(i)=ywave1(i)+wave1(j)*impule(i-j+1);
       end
   end
        if i>n_impule
            for j=i-n_impule:i
           ywave1(i)=ywave1(i)+wave1(j)*impule(i-j+1); 
            end
        end
end
figure(4)
plot(t1(1:n1),ywave1)
title('时间域滤波后')
xlabel('时间/s')
ylabel('count')
endtime=clock
figure(5)
fft_wave1=fft(wave1);
loglog(f_wave1(1:n1/2),abs(fft_wave1(1:n1/2)))
title('滤波前')
xlabel('频率/Hz')
ylabel('谱振幅')
figure(6)
fft_ywave1=fft(ywave1);
loglog(f_wave1(1:n1/2),abs(fft_ywave1(1:n1/2)))
title('滤波后')
xlabel('频率/Hz')
ylabel('谱振幅')
