%M02_07_butter_design
%通带截止频率并不是特指的是带通，高通 低通 带通 带阻都有通带截止频率
%通带截止频率是波特图中大于3dB的波段
clearvars
wp=6*2*pi;
ws=8*2*pi;
Ap=0.9;
Rp=-20*log10(Ap);
Ap1=10^(-Rp/20);
As=0.1;
As=0.2;
Rs=-20*log10(As);
As1=10^(-Rs/20);
[N,Wc]=buttord(wp,ws,Rp,Rs,'s');
fc=Wc/(2*pi);
[z,p,k]=butter(N,Wc,'s');
[b,a]=zp2tf(z,p,k);
[h,w]=freqs(b,a);
plot(w/(2*pi),abs(h),'b');
hold on
axis([0 15 0 1.1])
ylabel('归一化振幅')
grid on
xlabel('频率/Hz')

% 降一阶
[z,p,k]=butter(N-1,Wc,'s');
fc1=Wc/(2*pi);
[b,a]=zp2tf(z,p,k);
[h,w]=freqs(b,a);
plot(w/(2*pi),abs(h),'r');
hold on
axis([0 15 0 1.1])
ylabel('归一化振幅')
grid on
xlabel('频率/Hz')
