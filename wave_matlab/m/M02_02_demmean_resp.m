clear
%load firlh02.h %加载FIR滤波器系数
%x=firlh02;
%rate=x(1) %采样率
%num=x(2)
%for k=1:1:num
%    y(k)=x(k+2);
%end
%滑动平均的等效fir滤波器
M=200
num=2*M+1
rate=50
for i=1:num
    y(i)=1/num; %滑动平均的等效滤波器系数
end
[ B,theta,f1] = M02_02_firresp_func(y,num,rate );
figure()
subplot(2,1,1);
% plot(f1,A);
plot(f1,B);
xlabel('频率/Hz');
ylabel('振幅响应/dB');
title('滑动平均的振幅频率响应');
subplot(2,1,2);
p=unwrap(theta*pi/180)*180/pi;
plot(f1,p);
xlabel('频率/Hz');
ylabel('相位响应/度');
title('滑动平均的相位频率响应')
