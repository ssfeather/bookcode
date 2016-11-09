%Butterworth filter design
clear all
n1=10
n2=20
Fs=50   %������
fn=15    %�ս�Ƶ��
%wn=fn*2  /Fs % ���ο�˹��Ƶ�ʹ�һ����ԲƵ��
wn=fn*2*pi


ftype='low'
figure(1)
for n=n1:1:n2
co='g'
if n==n1
    co='b'   %��ɫΪ�ͽ׶�
end
 if n==n2
        co='r'    %��ɫΪ�߽׶�
 end
[z,p,k]=butter(n,wn,ftype,'s')
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a)
subplot(2,1,1)
plot(w/(2*pi),abs(h),co);hold on
%plot(w,abs(h),co);hold on
axis([0 25 0 1.1])
ylabel('��һ�����')
grid on
xlabel('Ƶ��/Hz')
%axis([0 1 0 1.1])
set(gca,'YTick',0:0.1:1.1)
subplot(2,1,2)
plot(w/(2*pi),unwrap(angle(h))*180/pi,co);hold on
axis([0 25 -2000 200])
ylabel('��λ/��')
end
grid on
xlabel('Ƶ��/Hz')

%--------------------------------------
n1=10
n2=20
Fs=50   %������
fn=5    %�ս�Ƶ��
%wn=fn*2  /Fs % ���ο�˹��Ƶ�ʹ�һ����ԲƵ��
wn=fn*2*pi
ftype='high'
figure(2)
for n=n1:1:n2
co='g'
if n==n1
    co='b'   %��ɫΪ�ͽ׶�
end
 if n==n2
        co='r'    %��ɫΪ�߽׶�
 end
[z,p,k]=butter(n,wn,ftype,'s')
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a)
subplot(2,1,1)
plot(w/(2*pi),abs(h),co);hold on
ylabel('��һ�����')
%plot(w,abs(h),co);hold on
axis([0 25 0 1.1])
grid on
xlabel('Ƶ��/Hz')
%axis([0 1 0 1.1])
set(gca,'YTick',0:0.1:1.1)
subplot(2,1,2)
plot(w/(2*pi),unwrap(angle(h))*180/pi,co);hold on
axis([0 25 -2000 200])
ylabel('��λ/��')
end
grid on
xlabel('Ƶ��/Hz')
%---------------------------------------
%--------------------------------------
n1=5
n2=10
Fs=50   %������
fn1=5    %�ս�Ƶ��
fn2=15
%wn=fn*2  /Fs % ���ο�˹��Ƶ�ʹ�һ����ԲƵ��
wn=[fn1  fn2]*2*pi  
figure(3)
for n=n1:1:n2
co='g'
if n==n1
    co='b'   %��ɫΪ�ͽ׶�
end
 if n==n2
        co='r'    %��ɫΪ�߽׶�
 end
[z,p,k]=butter(n,wn,'s')
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a)
subplot(2,1,1)
plot(w/(2*pi),abs(h),co);hold on
ylabel('��һ�����')
grid on
xlabel('Ƶ��/Hz')
%plot(w,abs(h),co);hold on
axis([0 25 0 1.1])
%axis([0 1 0 1.1])
set(gca,'YTick',0:0.1:1.1)
subplot(2,1,2)
plot(w/(2*pi),unwrap(angle(h))*180/pi,co);hold on
axis([0 25 -2000 200])
ylabel('��λ/��')
end
grid on
xlabel('Ƶ��/Hz')
%��ͨ�˲���
% �����㶨��ʽ���㼫��ֵs
fn1=15
wn1=fn1*2*pi
n1=5
n=n1
for k=1:n
    alpha=((2*k-1)*pi/(2*n)+pi/2)
    s(k)=wn1*(cos(alpha)+i*sin(alpha));
end
s
%��Matlab�������㼫��ֵp
[z,p,k]=butter(n,wn1,'s')
%�����㷨�����ļ���ֵ��ͬ
%s =-29.1242 +89.6350i  -76.2481 +55.3975i  -94.2478 + 0.0000i  -76.2481 -55.3975i  -29.1242 -89.6350i
%p = -29.1242 +89.6350i
%      -29.1242 -89.6350i
 %     -76.2481 +55.3975i
 %    -76.2481 -55.3975i
 %     -94.2478          
 % ��sƽ���ϻ�����ֲ�ͼ
 figure(4)
plot(real(s),imag(s),'+')
line([-100,100],[0,0])
line([0,0],[-100,100])
axis([-100 100 -100 100])
%��ͨ�˲���
% �����㶨��ʽ���㼫��ֵs
fn2=15
wn1=fn2*2*pi
n1=5
n=n1
for k=1:n
    alpha=((2*k-1)*pi/(2*n)+pi/2)
    s(k)=wn1*(cos(alpha)+i*sin(alpha));
end
s
%��Matlab�������㼫��ֵp
[z1,p1,k]=butter(n,wn1,'high','s')
%��ͨ��n����ֵ���
%�����㷨�����ļ���ֵ��ͬ
[z2,p2,k]=butter(n,wn1,'low','s')
%��ͨ��0�����
%��n��ͬ�ҽ�ֹƵ����ͬʱ����ͨ�͵�ͨ����ͬ�ļ���ֵ��
 % ��sƽ���ϻ�����ֲ�ͼ
 figure(5)
 %��ͨ
 wn1=15*2*pi
 n=10
[z1,p1,k]=butter(n,wn1,'low','s')
plot(real(p1),imag(p1),'b+')
line([-100,100],[0,0])
line([0,0],[-100,100])
axis([-100 100 -100 100])
xlabel('ʵ��')
ylabel('�鲿')
figure(6)
%��ͨ
wn2=5*2*pi
n=10
[z2,p2,k]=butter(n,wn2,'s')
plot(real(p2),imag(p2),'b+');hold on
plot(real(z2),imag(z2),'ro')
line([-100,100],[0,0])
line([0,0],[-100,100])
axis([-100 100 -100 100])
xlabel('ʵ��')
ylabel('�鲿')
figure(7)
%��ͨ
wn3=[5 15]*2*pi
n=5
[z3,p3,k]=butter(n,wn3,'s')
plot(real(p3),imag(p3),'b+');hold on
plot(real(z3),imag(z3),'ro')
line([-100,100],[0,0])
line([0,0],[-100,100])
axis([-100 100 -100 100])
xlabel('ʵ��')
ylabel('�鲿')
figure(8)
wn3=[5 15]*2*pi
n=5
[z3,p3,k]=butter(n,wn3,'s')
plot(real(p3),imag(p3),'b+');hold on
plot(real(z3),imag(z3),'ro')
line([-100,100],[0,0])
line([0,0],[-100,100])
axis([-100 100 -100 100])
xlabel('ʵ��')
ylabel('�鲿')
%-----------------------------------------
n=5
[z,p,k]=buttap(n)  %�õ�������˹��ͨ�˲���ԭ��