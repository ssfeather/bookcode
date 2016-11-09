%M02_07_analfilter_freq.m
%����ģ���˲�����Ƶ��������˲�
%�˲���ʾ�������׸�ͨ������˹�˲���
%��ֹƵ��Ϊ1Hz��
%M02_07_butter_design
clear all
N=2   %����
Wc=1*2*pi %��ֹƵ��1Hz
fc=Wc/(2*pi)
[z,p,k]=butter(N,Wc,'high','s')
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a);
w
wl=length(w)
figure(1)
subplot(2,1,1)
%semilogx(w/(2*pi),abs(h),'b');hold on   %��Ƶ��Ӧ
plot(w/(2*pi),abs(h),'b');hold on
%plot(w,abs(h),co);hold on
axis([0 15 0 1.1])
ylabel('��һ�����')
grid on
xlabel('Ƶ��/Hz')
%axis([0 1 0 1.1])
%set(gca,'YTick',0:0.1:1.1)
subplot(2,1,2)
%semilogx(w/(2*pi),unwrap(angle(h))*180/pi,'b');hold on
plot(w/(2*pi),unwrap(angle(h))*180/pi,'b');hold on
axis([0 15 -1000 1000])
grid on
ylabel('��λ/��')
xlabel('Ƶ��/Hz')
%-------------------------------------------------------
% ����ʾ�������Σ��ͳ�����̨CTS-1��ֱ���¼M7.72013��4��16������-�ͻ�˹̹�������
%XX_BCH_BHZ_2.txt
load XX_BCH_BHZ_2.txt
Fs=100
wave=XX_BCH_BHZ_2
wavelen=length(wave)
n1=6000
n2=4000
n2=0
n1=60000
wave1([1:n1])=wave([n2+1:n2+n1]);
t1=([1:n1])/Fs;
figure(2)
plot(t1,wave1)
xlabel('ʱ��/s')
ylabel('count')
fft_wave1=fft(wave1);
w_wave1=([1:n1])*2*pi*Fs/n1;
f_wave1=w_wave1/(2*pi);
h_wave1=freqs(b,a,w_wave1);
h1_wave1=zeros(1,n1);
%�����븵��Ҷ�任�õ���ǰ�����˹�����ʽ���ݶ�Ӧ���˲���
%�����2012����429ҳ��
for ii=1:n1/2
    h1_wave1(ii)=h_wave1(ii);
    h1_wave1(n1-ii+1)=conj(h1_wave1(ii));
end
figure(3)
plot(f_wave1,abs(h1_wave1))
axis([0 100 0 1.1])
%----Ƶ�����˲�
for i=1:n1
fft_ywave1(i)=fft_wave1(i)*h1_wave1(i);
end
ywave1=ifft(fft_ywave1)
figure(4)
plot(t1,ywave1)
xlabel('ʱ��/s')
ylabel('count')
figure(5)
loglog(f_wave1(1:n1/2),abs(fft_wave1(1:n1/2)))
title('�˲�ǰ')
xlabel('Ƶ��/Hz')
ylabel('�����')
figure(6)
loglog(f_wave1(1:n1/2),abs(fft_ywave1(1:n1/2)))
title('�˲���')
xlabel('Ƶ��/Hz')
ylabel('�����')

