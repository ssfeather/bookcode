%M02_07_butter_design

clearvars
wp=6*2*pi;                          % 通带边界频率
ws=8*2*pi;                          % 阻带边界频率
ap=0.9;                             % 通带振幅频率响应的最大值与通带振幅频率响应的最小值比
as=0.1;                             % 通带振幅频率响应的最大值与阻带振幅频率响应的最大值比

%--滤波器设计
rp=-20*log10(ap);                   % 计算通带纹波
rs=-20*log10(as);                   % 计算阻带衰减
[n,wc]=buttord(wp,ws,rp,rs,'s');    % 计算巴特沃斯滤波器的n：阶数、wc：截止角频率
[z,p,k]=butter(n,wc,'s');           % 计算滤波器的z：零点矢量、p：极点矢量、k：增益
[b,a]=zp2tf(z,p,k);                 % 计算传递函数有理分式的b：分子多项式系数矢量、a：分母多项式系数矢量
[h,w]=freqs(b,a);                   % 自动挑选200个频率点来计算频率响应h和相应频点w
fc=wc/(2*pi);                       % 计算截止频率

%--计算降一阶滤波器频率响应
[zd,pd,kd]=butter(n-1,wc,'s');
[bd,ad]=zp2tf(zd,pd,kd);
[hd,wd]=freqs(bd,ad);

%--绘制滤波器频率响应曲线------------------------------------------------------
scrsz = get(groot,'ScreenSize');
figure('Position',[scrsz(3)/3 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2])
axis([0 15 0 1.1]);
set(gca,'XTick',0:1:15,'XGrid','on','XMinorTick','on');
set(gca,'YTick',0:0.1:1,'YGrid','on','YMinorTick','on');
set(gca,'GridLineStyle',':');
set(gca,'Box','on');
ylabel('归一化振幅')
xlabel('频率/Hz')
hold on

plot(w/(2*pi),abs(h),'b');
plot(wd/(2*pi),abs(hd),'r');

line([wp/(2*pi),wp/(2*pi)],[0,1.1],'LineStyle','--','LineWidth',0.2)
text(wp/(2*pi),1.1,'wp','horiz','center','vert','bottom')
line([ws/(2*pi),ws/(2*pi)],[0,1.1],'LineStyle','--','LineWidth',0.2)
text(ws/(2*pi),1.1,'ws','horiz','center','vert','bottom')
line([wc/(2*pi),wc/(2*pi)],[0,1.1],'LineStyle','--','LineWidth',0.2)
text(wc/(2*pi),1.1,'wc','horiz','center','vert','bottom')
line([0,wp/(2*pi)],[ap,ap],'LineStyle','--','LineWidth',0.5)
text(wc/(2*pi)/2,ap,'ap=0.9','horiz','center','vert','bottom')
line([0,ws/(2*pi)],[as,as],'LineStyle','--','LineWidth',0.5)
text(wc/(2*pi)/2,as,'as=0.1','horiz','center','vert','bottom')
line([0,wc/(2*pi)],[0.707,0.707],'LineStyle','-.','LineWidth',0.5,'Color',[0 0 0])
text(wc/(2*pi)/2,0.707,'振幅衰减3dB','horiz','center','vert','bottom')



