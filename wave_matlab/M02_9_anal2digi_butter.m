%M02_10_anal2digi_butter.m
%
clear all
fs=100  %������
k=1       %����
f0=1 %��ֹƵ��
%���׸�ͨ������˹�˲���
%s^2/(s^2+root(2)*omega0*s+omega0^2
omega0=2*pi*f0
r2=sqrt(2)
%���ݺ��������ʽ���ӣ��μ�ʽ��2.61��
b(1)=1
b(2)=0
b(3)=0
%���ݺ�����ĸ
a(1)=1
a(2)=r2*omega0
a(3)=omega0^2
%���ͼ���
ze(1)=0
ze(2)=0
po(1)=-r2*omega0*(1+1i)/2
po(2)=-r2*omega0*(1-1i)/2
po0=roots(b)
ze0=roots(a)
num_ze=2
num_po=2
[mn,nn] = size(ze)
%˫���Ա任��ʹ���㼫��
[zd,pd,kd]=bilinear(ze',po',k,fs)
num_zd=length(zd)
num_pd=length(pd)
figure(1)
for i=1:num_zd
plot(real(zd(i)),imag(zd(i)),'o');hold on
end
for i=1:num_pd
    plot(real(pd(i)),imag(pd(i)),'+');hold on
end
for i=1:360
    x(i)=sin(i*pi/180);
    y(i)=cos(i*pi/180);
end
plot(x,y);
title('���ֶ��׸�ͨ������˹�˲������㼫��ֲ�')
xlabel('zƽ��ʵ��')
ylabel('zƽ���鲿')
legend('���','���','����','����')
line([-1,1.5],[0,0])
line([0,0],[-1,1])


%˫���Ա任��ʹ�������ʽ�ķ���b�ͷ�ĸa
[bz,az]=bilinear(b,a,fs)
zd0=roots(bz)
pd0=roots(az)
[h0,w0]=freqz(bz,az,fs);  
%������Ӧ���䷨
bb=b
aa=a
[bz1,az1]=impinvar(b,a,fs)   %ע�⣬������Ӧ���䷨�����ڸ�ͨ�ʹ����˲���
[h2,w2]=freqz(bz1,az1,fs);
%
%�������˲������㼫��
bzlen=length(bz1)
azlen=length(az1)
zd1=roots(bz1)
pd1=roots(az1)
figure(2)
zplane(bz,az)   %˫����
figure(3)
zplane(zd1',pd1')
zd0'
pd0'
figure(4)
[h00,w00]=freqs(b,a);  %ģ���˲���
loglog(w00/(2*pi),abs(h00));hold on
loglog(w0*fs/(2*pi),abs(h0),'g');hold on  %˫���Ա任
loglog(w2*fs/(2*pi),abs(h2),'r'); %������Ӧ����


legend('ģ���˲���','˫���Ա任','������Ӧ����')
%ֱ�Ӽ���˫���Ա任�õ��ļ���
num=(1+po(1)/(2*fs))
den=(1-po(1)/(2*fs))
pd1=num/den
%��ͨ�˲���
%omega0^2/(s^2+root(2)*omega0*s-omega0^2
omega0=2*pi*f0
r2=sqrt(2)
%���ݺ��������ʽ���ӣ��μ�ʽ��2.61��
%������
%���ݺ�����ĸ
p(1)=-4.4429+4.4429i
p(2)=-4.4429-4.4429i

[b,a]=zp2tf([],p,-omega0^2)
[h4,w4]=freqs(b,a);
figure(5)
loglog(w4/(2*pi),abs(h4),'r')
N=2 
fc=1
Wc=fc*2*pi
[z,p,k]=butter(N,Wc,'s')
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a);
loglog(w/(2*pi),abs(h))
%��������˲���
k=1
[bd_bi,ad_bi]=bilinear(b,a,fs);
[bd_im,ad_im]=impinvar(b,a,fs);
[h_bi,w_bi]=freqz(bd_bi,ad_bi,fs);
[h_im,w_im]=freqz(bd_im,ad_im,fs);
figure(6)
loglog(w_bi*fs/(2*pi),abs(h_bi),'r');hold on
loglog(w_im*fs/(2*pi),abs(h_im));hold on
loglog(w/(2*pi),abs(h),'g')
legend('˫���Ա任','������Ӧ����','ģ���˲���')
xlabel('Ƶ��/Hz')
ylabel('��һ�����')
title({'��ͨ�˲��������Ӧ����ֹƵ��=',fc,'Hz'})
%���޲�ֽ���
r2=sqrt(2)
f0=1
fs=100
omega0=2*pi*f0
%ģ�⴫�ݺ��������ʽ���ӣ��μ�ʽ��2.61��
b(1)=1
b(2)=0
b(3)=0
%���ݺ�����ĸ
a(1)=1
a(2)=r2*omega0
a(3)=omega0^2
k=fs^2+r2*omega0*fs+omega0^2
b1(1)=1/k;
b1(2)=-2/k;
b1(3)=1/k;

a1(1)=1;
a1(2)=-(2*(fs^2)+r2*omega0*fs)/k;
a1(3)=fs^2/k;
aa=a1
bb=b1
num=200
[h_de,w_de]=freqz(b1,a1,num);
%��һ��
f_de=w_de*fs/(2*pi)
df=fs/(2*num)
n_f=f0/df+1
f_n=f_de(n_f)
norm=abs(h_de(n_f))/0.707
figure(7)
[h00,w00]=freqs(b,a);  %ģ���˲���
loglog(w00/(2*pi),abs(h00),'-y');hold on
loglog(w_de*fs/(2*pi),abs(h_de)/norm);hold on
f0=10
fs=100
omega0=2*pi*f0
%���ݺ��������ʽ���ӣ��μ�ʽ��2.61��
b(1)=1
b(2)=0
b(3)=0
%���ݺ�����ĸ
a(1)=1
a(2)=r2*omega0
a(3)=omega0^2
%------------------------------���޲�ֽ���
k=fs^2+r2*omega0*fs+omega0^2
b1(1)=1/k;
b1(2)=-2/k;
b1(3)=1/k;
r2=sqrt(2)

a1(1)=1;
a1(2)=-(2*(fs^2)+r2*omega0*fs)/k;
a1(3)=fs^2/k;
aa=a1
bb=b1
[h_de,w_de]=freqz(b1,a1,num);
%��һ��
f_de=w_de*fs/(2*pi)
df=fs/(2*num)
n_f=f0/df+1
f_n=f_de(n_f)
norm=abs(h_de(n_f))/0.707
figure(7)
[h00,w00]=freqs(b,a);  %ģ���˲���
loglog(w00/(2*pi),abs(h00),'-g');hold on
loglog(w_de*fs/(2*pi),abs(h_de)/norm,'r')
legend('ģ�⣬fc=1Hz','���֣�fc=1Hz','ģ�⣬fc=10Hz','���֣�fc=10Hz')


