%向上重采样（由100sps增到500sps）
clear all
t0=0.01;%原采样间隔（每秒100点） 
%t0=0.02;%原采样间隔（每秒50点）
Fs0=1/t0;
f0=Fs0/2; %原截止频率=1/2采样率
t1=0.002;%新采样间隔（每秒500点）
%t1=0.01;%新采样间隔（每秒100点） 
Fs1=1/t1;%新采样率
ratio=t1/t0
N0=4000;%原数据点数
N1=floor(N0*t0/t1)
n=0:N0-1;t=n/Fs0;
zeta=Fs1/(2*f0)  % 重采样的低通滤波器参数
zeta=1
xn0=sin(2*pi*0.1*t)+0.5*sin(2*pi*30*t);

%xn0=sin(2*pi*0.1*t);
figure(1);
Nf=100; 
plot(t(1:N0-Nf),xn0(1+Nf:N0),'r');hold on
plot(t(1:N0-Nf),xn0(1+Nf:N0),'r*');hold on
for m=floor(Nf/ratio)+Nf+1:N1-floor(Nf/ratio)-1
    x(m)=0;
    for n=floor(m*ratio)-Nf:1:floor(m*ratio)+Nf
        x(m)=x(m)+xn0(n)*sinc(zeta*(m*ratio-n));
    end
end
 n1=0:N1-1;tt1=n1/Fs1;
 nn1=length(n1)
 ntt1=length(tt1)
 nx=length(x)
 %figure(2);
 %plot(tt1,x(1:nn1));
 plot(tt1(floor(Nf/ratio)+Nf+1-Fs1-5+1:N1-floor(Nf/ratio)-1-Fs1-5+1),x(floor(Nf/ratio)+Nf+1:N1-floor(Nf/ratio)-1)*zeta,'b');hold on
 plot(tt1(floor(Nf/ratio)+Nf+1-Fs1-5+1:N1-floor(Nf/ratio)-1-Fs1-5+1),x(floor(Nf/ratio)+Nf+1:N1-floor(Nf/ratio)-1)*zeta,'b.');hold on
 ty=0:0.001:4000*t0-Nf/Fs0;
 z=sin(2*pi*0.1*(ty+Nf/Fs0))+0.5*sin(2*pi*30*(ty+Nf/Fs0));
 %z=sin(2*pi*0.1*(ty+Nf/Fs0))
 plot(ty,z,'g')
 title('信号恢复示例')
 xlabel('时间/s')
 ylabel('振幅')

