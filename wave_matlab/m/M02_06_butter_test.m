%Butterworth filter design
clear all
n1=10
n2=20
Fs=50   %采样率
fn=15    %拐角频率
%wn=fn*2  /Fs % 按奈奎斯特频率归一化的圆频率
wn=fn*2*pi


ftype='low'
figure(1)
for n=n1:1:n2
co='g'
if n==n1 
    co='b'   %蓝色为低阶端
end
 if n==n2
        co='r'    %红色为高阶端
 end
[z,p,k]=butter(n,wn,ftype,'s')
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a)
subplot(2,1,1)
plot(w/(2*pi),abs(h),co);hold on
%plot(w,abs(h),co);hold on
axis([0 25 0 1.1])
ylabel('归一化振幅')
grid on
xlabel('频率/Hz')
%axis([0 1 0 1.1])
set(gca,'YTick',0:0.1:1.1)
subplot(2,1,2)
plot(w/(2*pi),unwrap(angle(h))*180/pi,co);hold on
axis([0 25 -2000 200])
ylabel('相位/°')
end
grid on
xlabel('频率/Hz')

%--------------------------------------
n1=10
n2=20
Fs=50   %采样率
fn=5    %拐角频率
%wn=fn*2  /Fs % 按奈奎斯特频率归一化的圆频率
wn=fn*2*pi
ftype='high'
figure(2)
for n=n1:1:n2
co='g'
if n==n1
    co='b'   %蓝色为低阶端
end
 if n==n2
        co='r'    %红色为高阶端
 end
[z,p,k]=butter(n,wn,ftype,'s')
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a)
subplot(2,1,1)
plot(w/(2*pi),abs(h),co);hold on
ylabel('归一化振幅')
%plot(w,abs(h),co);hold on
axis([0 25 0 1.1])
grid on
xlabel('频率/Hz')
%axis([0 1 0 1.1])
set(gca,'YTick',0:0.1:1.1)
subplot(2,1,2)
plot(w/(2*pi),unwrap(angle(h))*180/pi,co);hold on
axis([0 25 -2000 200])
ylabel('相位/°')
end
grid on
xlabel('频率/Hz')
%---------------------------------------
%--------------------------------------
n1=5
n2=10
Fs=50   %采样率
fn1=5    %拐角频率
fn2=15
%wn=fn*2  /Fs % 按奈奎斯特频率归一化的圆频率
wn=[fn1  fn2]*2*pi  
figure(3)
for n=n1:1:n2
co='g'
if n==n1
    co='b'   %蓝色为低阶端
end
 if n==n2
        co='r'    %红色为高阶端
 end
[z,p,k]=butter(n,wn,'s')
[b,a]=zp2tf(z,p,k)
[h,w]=freqs(b,a)
subplot(2,1,1)
plot(w/(2*pi),abs(h),co);hold on
ylabel('归一化振幅')
grid on
xlabel('频率/Hz')
%plot(w,abs(h),co);hold on
axis([0 25 0 1.1])
%axis([0 1 0 1.1])
set(gca,'YTick',0:0.1:1.1)
subplot(2,1,2)
plot(w/(2*pi),unwrap(angle(h))*180/pi,co);hold on
axis([0 25 -2000 200])
ylabel('相位/°')
end
grid on
xlabel('频率/Hz')
%低通滤波器
% 按极点定义式计算极点值s
fn1=15
wn1=fn1*2*pi
n1=5
n=n1
for k=1:n
    alpha=((2*k-1)*pi/(2*n)+pi/2)
    s(k)=wn1*(cos(alpha)+i*sin(alpha));
end
s
%用Matlab函数计算极点值p
[z,p,k]=butter(n,wn1,'s')
%两种算法给出的极点值相同
%s =-29.1242 +89.6350i  -76.2481 +55.3975i  -94.2478 + 0.0000i  -76.2481 -55.3975i  -29.1242 -89.6350i
%p = -29.1242 +89.6350i
%      -29.1242 -89.6350i
 %     -76.2481 +55.3975i
 %    -76.2481 -55.3975i
 %     -94.2478          
 % 在s平面上画极点分布图
 figure(4)
plot(real(s),imag(s),'+')
line([-100,100],[0,0])
line([0,0],[-100,100])
axis([-100 100 -100 100])
%高通滤波器
% 按极点定义式计算极点值s
fn2=15
wn1=fn2*2*pi
n1=5
n=n1
for k=1:n
    alpha=((2*k-1)*pi/(2*n)+pi/2)
    s(k)=wn1*(cos(alpha)+i*sin(alpha));
end
s
%用Matlab函数计算极点值p
[z1,p1,k]=butter(n,wn1,'high','s')
%高通有n个零值零点
%两种算法给出的极点值相同
[z2,p2,k]=butter(n,wn1,'low','s')
%低通有0个零点
%当n相同且截止频率相同时，高通和低通有相同的极点值。
 % 在s平面上画极点分布图
 figure(5)
 %低通
 wn1=15*2*pi
 n=10
[z1,p1,k]=butter(n,wn1,'low','s')
plot(real(p1),imag(p1),'b+')
line([-100,100],[0,0])
line([0,0],[-100,100])
axis([-100 100 -100 100])
xlabel('实部')
ylabel('虚部')
figure(6)
%高通
wn2=5*2*pi
n=10
[z2,p2,k]=butter(n,wn2,'s')
plot(real(p2),imag(p2),'b+');hold on
plot(real(z2),imag(z2),'ro')
line([-100,100],[0,0])
line([0,0],[-100,100])
axis([-100 100 -100 100])
xlabel('实部')
ylabel('虚部')
figure(7)
%带通
wn3=[5 15]*2*pi
n=5
[z3,p3,k]=butter(n,wn3,'s')
plot(real(p3),imag(p3),'b+');hold on
plot(real(z3),imag(z3),'ro')
line([-100,100],[0,0])
line([0,0],[-100,100])
axis([-100 100 -100 100])
xlabel('实部')
ylabel('虚部')
figure(8)
wn3=[5 15]*2*pi
n=5
[z3,p3,k]=butter(n,wn3,'s')
plot(real(p3),imag(p3),'b+');hold on
plot(real(z3),imag(z3),'ro')
line([-100,100],[0,0])
line([0,0],[-100,100])
axis([-100 100 -100 100])
xlabel('实部')
ylabel('虚部')
%-----------------------------------------
n=5
[z,p,k]=buttap(n)  %得到巴特沃斯低通滤波器原型
