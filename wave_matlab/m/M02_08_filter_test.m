%FIR滤波器试验（1.4.7.3节，生成图1.15-1.22，以及图1.11b、1.13b）
%输入信号:采样率为200sps的阶跃信号
clearvars;

%% 线性相位滤波器
orgDat     = load('M02_firln02.h');
rate       = orgDat(1);
period     = 1/rate;                    % 采样率
firLen     = orgDat(2);                 % 滤波器系数长度
lnfDat     = orgDat(3:length(orgDat));

%生成假想输入信号
noeLen = 200;
xstep   = zeros(1,noeLen);
nulLen = 300;
for i=1:nulLen
     xstep(noeLen+i)=sin(2*pi*10*i*period)+0.5*sin(2*pi*20*i*period+pi/2); %两个正弦信号叠加
end
genLen = length(xstep);

% 褶积滤波
lnfFir = zeros(1,genLen);
for i=firLen+1:genLen       
    for j=1:firLen
        lnfFir(i)=lnfFir(i)+lnfDat(j)*xstep(i-j+1);
    end
end

% 最小相位滤波器
orgDat      = load('M02_firm02.h');
rate        = orgDat(1);
period      = 1/rate;
firLen      = orgDat(2);
genLen      = length(xstep);
mphFir      = zeros(1,genLen);
mphDat      = orgDat(3:length(orgDat));
for i=firLen+1:genLen
    for j=1:firLen
        mphFir(i)=mphFir(i)+mphDat(j)*xstep(i-j+1);
    end
end

% 信号恢复
cphCon = deconv(lnfFir,lnfDat);     % 线性相位
mphCon = deconv(mphFir,mphDat);     % 最小相位

scrsz = get(groot,'ScreenSize');
figure('Position',[scrsz(3)/3 scrsz(4)/1.5 scrsz(3)/2 scrsz(4)/1.5]);
subplot(5,1,1)
plot(xstep)
title('假想输入信号')

subplot(5,1,2)
plot(lnfFir)
title('褶积滤波')

subplot(5,1,4)
plot(mphFir)
title('最小相位滤波')

subplot(5,1,3)
plot(cphCon)
title('线性相位信号恢复')

subplot(5,1,5)
plot(mphCon)
title('最小相位信号恢复')

%% 用Matlab工具画响应曲线
figure('Name','用Matlab工具画响应曲线')
freqz(lnfDat,1)   %线性相位FIR
title('线性相位FIR')
figure('Name','用Matlab工具画响应曲线')
freqz(mphDat,1)   %最小相位FIR
title('最小相位FIR')

%% 使用Matlab函数滤波
scrsz = get(groot,'ScreenSize');
figure('Name','使用Matlab函数滤波','Position',[scrsz(3)/3 scrsz(4)/1.5 scrsz(3)/2 scrsz(4)/1.5]);
[lnfFir,filSta]=filter(lnfDat,1,xstep);   %FIR滤波器线性相位,zf0滤波器最终状态
zf0l=length(filSta);
tesFf=filtfilt(lnfDat,1,xstep);  %正反滤波

subplot(2,2,1)
plot(xstep)
subplot(2,2,3)
plot(lnfFir)
title('filter')
subplot(2,2,2)
plot(xstep)
subplot(2,2,4)
plot(tesFf)
title('filtfilt')

%% 按公式（2.97）计算滤波器最终状态
filCoeb     = lnfDat;
filCoea     = 1;
coebLen     = length(filCoeb);
coeaLen     = length(filCoea);
maxLen      = max(coebLen,coeaLen)-1;
filStaf     = zeros(1,maxLen);
for j=1:maxLen
    if j<coebLen
        for i=j:coebLen-1
            filStaf(j)=filStaf(j)+filCoeb(i+1)*xstep(genLen+j-i);
        end
    end
    if coeaLen>1 && j+1<coeaLen
        for i=j+1:coeaLen-1
            filStaf(j)=filStaf(j)+filCoea(i+1)*y(genLen+j-i+1);
        end
    end
end
filStaf(j)=filStaf(j)/filCoea(1);

figure('Name','按公式（2.97）计算滤波器最终状态')
%计算出滤波器最终状态
set(plot(filStaf),'LineWidth',3,'LineStyle','-','Color',[1 0 0]);
hold on        
%用filter函数得到的结果一致
set(plot(filSta),'LineWidth',1,'LineStyle','-','Color',[0 0 1]);
title('按公式（2.97）与使用filter函数计算滤波器最终状态的比较')

%% 利用滤波器最终状态作为下一段信号滤波的初始状态
nulLen      = 300;
noeLen      = 200;
inDat       = zeros(1,nulLen);
for i=1:nulLen
     inDat(i)=sin(2*pi*10*i*period)+0.5*sin(2*pi*20*i*period+pi/2); %两个正弦信号叠加
end
for i=1:noeLen
    inDat(nulLen+i)=0;
end
datLen      = length(inDat);
sumLen      = genLen+datLen;

scrsz = get(groot,'ScreenSize');
figure('Position',[scrsz(3)/3 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2]);
%两段信号连接
splDat(1:genLen)        = xstep(1:genLen);
splDat(genLen+1:sumLen) = inDat(1:datLen);
subplot(2,2,1)
plot(splDat)
title('两段信号连接')

%两段合为一段滤波
lnfFir2                 = filter(filCoeb,filCoea,splDat); 
subplot(2,2,2)
plot(lnfFir2)
title('两段合为一段滤波')

%分两段滤波，第2段利用第1段的zf1
[lnfFir21,zf1]          = filter(filCoeb,filCoea,xstep);
lnfFir22                = filter(filCoeb,filCoea,inDat,zf1); %第2段用第1段的滤波器状态作为初始状态
lnfFir2(1:genLen)       = lnfFir21(1:genLen);
lnfFir2(genLen+1:sumLen)= lnfFir22(1:datLen);
subplot(2,2,3)
plot(lnfFir2)
title('第2段用第1段的滤波器状态为初始状态')

%可以看到图13与图11一致
[lnfFir22,filSta2]=filter(filCoeb,filCoea,inDat);  %第2段不用第1段的滤波器状态作为初始状态
lnfFir2(genLen+1:sumLen)=lnfFir22(1:datLen);
subplot(2,2,4)
plot(lnfFir2)   
title('第2段不用第1段的滤波器状态为初始状态')
%结果两段的输出不能衔接

%% 按式（2.98）计算第1段滤波器最终状态，作为第2段滤波器初始状态，按式（2.99）计算第2段的滤波输出
%按公式（2.98）计算滤波器最终状态
filcoe      = lnfDat;
filCoea     = 1;
coebLen     = length(filcoe);
coeaLen     = length(filCoea);
maxLen      = max(coebLen,coeaLen)-1;
for j=1:maxLen
    filStaf(j)=0;
    if j<coebLen
        for i=j:coebLen-1
            filStaf(j)=filStaf(j)+filcoe(i+1)*xstep(genLen+j-i);
        end
    end
    if coeaLen>1 && j+1<coeaLen
        for i=j+1:coeaLen-1
            filStaf(j)=filStaf(j)+filCoea(i+1)*y(genLen+j-i+1);
        end
    end
end
filStaf(j)      = filStaf(j)/filCoea(1);

scrsz = get(groot,'ScreenSize');
figure('Position',[scrsz(3)/3 scrsz(4)/2 scrsz(3)/3 scrsz(4)/1.5]);

subplot(4,1,1)
plot(filStaf,'r');  %计算出滤波器最终状态
title('第1段滤波器最终状态')

% 式（2.99）
filDat2 = zeros(1,maxLen);
for k=1:maxLen
    filDat2(k)=0;
    minLen=min(k,coebLen-1);
    if minLen>0
        for i=1:minLen
            filDat2(k)=filDat2(k)+filcoe(i)*inDat(k-i+1);
        end
    end
    cminLen=min(k,coeaLen-1);
    if cminLen>1
        for i=2:cminLen
            filDat2(k)=filDat2(k)-filCoea(i)*filDat2(k-i+2);
        end
    end
    filDat2(k)=filDat2(k)/filCoea(1);
    filDat2(k)=filDat2(k)+filStaf(k);
end
     
for i=maxLen+1:datLen      
    filDat2(i)=0;
    for j=1:coebLen
        filDat2(i)=filDat2(i)+filcoe(j)*inDat(i-j+1);
    end
    if coeaLen>1
        for j=2:coeaLen
            filDat2(i)=filDat2(i)-filCoea(j)*filDat2(i-j+1);
        end
    end
    filDat2(i)=filDat2(i)/filCoea(1);
end
    
subplot(4,1,2)
plot(inDat,'r');%第2段输入信号
title('第2段输入信号')
subplot(4,1,3)
plot(filDat2)   %第2段输出的滤波后信号,利用了第1段的滤波器最终状态
title('利用第1段的滤波器最终状态,滤波后的第2段信号')

%两段连接
lnfFir2(genLen+1:sumLen)=filDat2(1:datLen);
subplot(4,1,4)
plot(lnfFir2)
title('连接后的滤波数据')
%连接成功
