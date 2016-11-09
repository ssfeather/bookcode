%  去掉分段线性趋势
sig = [0 1 -2 1 0 1 -2 1 0 0 1 -2 1 0 1 -2 1 0];      % 无线性趋势的信号
trend = [0 1 2 3 4 3 2 1 0 0 1 2 3 4 3 2 1 0];      % 两段线性趋势
x = sig+trend;                    % 信号+趋势
y = detrend(x,'linear',[5 9 10 14])         % 断点在第5个元素
plot(x,'b.');hold on
plot(y,'r*');hold on
plot(trend,'g+')
title('去线性趋势示例')
xlabel('数据点序号')