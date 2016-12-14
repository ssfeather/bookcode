%M02_07_butter_design
clear all
wp=6*2*pi
ws=8*2*pi
%Ap=0.8
Ap=0.9
Rp=-20*log10(Ap)
%Rp=3
Ap1=10^(-Rp/20)
%Ap=0.2
As=0.1
As=0.2
Rs=-20*log10(As)
As1=10^(-Rs/20)
[N,Wc]=buttord(wp,ws,Rp,Rs,'s')
fc=Wc/(2*pi)
[z,p,k]=butter(N,Wc,'s')
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a);
%subplot(2,1,1)
plot(w/(2*pi),abs(h),'b');hold on
%plot(w,abs(h),co);hold on
axis([0 15 0 1.1])
ylabel('归一化振幅')
grid on
xlabel('频率/Hz')
%axis([0 1 0 1.1])
%set(gca,'YTick',0:0.1:1.1)
%subplot(2,1,2)
%plot(w/(2*pi),unwrap(angle(h))*180/pi,'b');hold on
%axis([0 15 -2000 200])
%ylabel('相位/°')

% 降一阶
[z,p,k]=butter(N-1,Wc,'s')
fc1=Wc/(2*pi)
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a);
%subplot(2,1,1)
plot(w/(2*pi),abs(h),'r');hold on
%plot(w,abs(h),co);hold on
axis([0 15 0 1.1])
ylabel('归一化振幅')
grid on
xlabel('频率/Hz')
