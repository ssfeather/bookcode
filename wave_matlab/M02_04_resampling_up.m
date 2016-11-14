%向上重采样（由100sps增到500sps）
clear all
orgInterval=0.01;                                   %原采样间隔（每秒100点） 
orgFs=1/orgInterval;                                %原采样率
orgCutFre=orgFs/2;                                  %原截止频率=1/2采样率
newInterval=0.002;                                  %新采样间隔（每秒500点） 
newFs=1/newInterval;                                %新采样率
newOldRatio=newInterval/orgInterval;                %新旧采样率比
odatLength=4096;                                    %原数据点数
ndatLength=floor(odatLength*orgInterval/newInterval);%新数据点数

%生成0.01Hz和30Hz的混合信号
n=0:odatLength-1;
t=n/orgFs;
xn0=sin(2*pi*0.1*t)+0.5*sin(2*pi*30*t);

zeta=newFs/(2*orgCutFre);                           %重采样的低通滤波器参数
zeta=1;

Nf=100; 
figure(2)
plot(t(1:odatLength-Nf),xn0(1+Nf:odatLength),'r');
%{
hold on
plot(t(1:odatLength-Nf),xn0(1+Nf:odatLength),'r*');
hold on
%}
for m=floor(Nf/newOldRatio)+Nf+1:ndatLength-floor(Nf/newOldRatio)-1
    x(m)=0;
    for n=floor(m*newOldRatio)-Nf:1:floor(m*newOldRatio)+Nf
        x(m)=x(m)+xn0(n)*sinc(zeta*(m*newOldRatio-n));
    end
end
n1=0:ndatLength-1;tt1=n1/newFs;
nn1=length(n1);
ntt1=length(tt1);
nx=length(x);
figure(3)
%plot(tt1,x(1:nn1));
plot(tt1(floor(Nf/newOldRatio)+Nf+1-newFs-5+1:ndatLength-floor(Nf/newOldRatio)-1-newFs-5+1),x(floor(Nf/newOldRatio)+Nf+1:ndatLength-floor(Nf/newOldRatio)-1)*zeta,'b');
hold on
plot(tt1(floor(Nf/newOldRatio)+Nf+1-newFs-5+1:ndatLength-floor(Nf/newOldRatio)-1-newFs-5+1),x(floor(Nf/newOldRatio)+Nf+1:ndatLength-floor(Nf/newOldRatio)-1)*zeta,'b.');
hold on
ty=0:0.001:4000*orgInterval-Nf/orgFs;
z=sin(2*pi*0.1*(ty+Nf/orgFs))+0.5*sin(2*pi*30*(ty+Nf/orgFs));
%z=sin(2*pi*0.1*(ty+Nf/Fs0))
plot(ty,z,'g')
title('信号恢复示例')
xlabel('时间/s')
ylabel('振幅')

