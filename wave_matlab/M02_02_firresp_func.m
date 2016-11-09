function [ B,theta,f1] = M02_02_firresp_func(y,num,rate )
% 输入
%       y:    fir滤波器系数矢量
%       num:  fir滤波器系数个数
%       rate: 波形数据采样率
% 输出
%       B:     fir滤波器振幅响应（dB）
%       theta: fir滤波器相位响应（度）
%       f1:    频率（Hz）
%
% 用Z变换表示FIR滤波器的响应:
%   realF(f)=sum(y(k)*cos(-2*pi*T*k*f)
%   imagFf()=sum(y(k)*sin(-2*pi*T*k*f)
%   amp(f)=sqrt(real(F(f)).^2 + imag(F(f)).^2)
%   F(f)=complex(realF(f),imagF(f))
%   A(f)=abs(F(f))
%   theta(f)=angle(F(f))   in radians
%   Z = R.*exp(i*theta)

fmax=rate/2;
T=1/rate; %采样间隔
r=1/T;

for f=1:fmax*100
    f1(f)=f/100;
    realF(f)=0;
    imagF(f)=0;
    F(f)=0+0i;
    for k=1:num
       realF(f)=realF(f)+y(k)*cos(-2*pi*T*(k-num/2)*f1(f));
       imagF(f)=imagF(f)+y(k)*sin(-2*pi*T*(k-num/2)*f1(f));
    end
    
   F(f)=complex(realF(f),imagF(f));
   theta(f)=angle(F(f))*180/pi;
    
   A(f)=abs(F(f));
   B(f)=20*log10(A(f));
end

% figure(1)
% subplot(3,1,1);
% plot(f1,A);
% plot(f1,B);
% xlabel('frequency/Hz');
% ylabel('Amplitude resp./dB');
% title({'FIR filter firlh02 frequency response, sample rate=',r,'s/s'});
% subplot(3,1,2);
% p=unwrap(theta*pi/180)*180/pi;
% plot(f1,p);
% xlabel('frequency/Hz');
% ylabel('Phase resp./Degrees');
% subplot(3,1,3);
% plot(y,'.');
        
        
