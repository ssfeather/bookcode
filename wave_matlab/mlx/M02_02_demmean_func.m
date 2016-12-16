function [ Y,m ] =M02_02_demmean_func(X,M )
%demmean: 去掉滑动均值
%   采用公式见第1章 地震波形预处理
%   输入：
%      X:波形数据
%      M:滑动段长度，滑动平均值的长度为2M+1,要求数据长度>=2*M+1
%   输出：
%      Y:去除滑动平均值的波形数据
%      m:滑动平均值数据
%
narginchk(2,2)

n=length(X);
if n+1>2*M+1
    for i=1:M 
        m(i)=0;
        for k=1:2*M+1
            m(i)=m(i)+X(k);
        end
        m(i)=m(i)/(2*M+1);
        Y(i)=X(i)-m(i);
    end
    for i=M+1:n-M
        m(i)=0;
        for k=1:2*M+1
            m(i)=m(i)+X(i-M+k-1);
        end
        m(i)=m(i)/(2*M+1);
        Y(i)=X(i)-m(i);
    end
    for i=n-M+1:n
        m(i)=0;
        for k=1:2*M+1
            m(i)=m(i)+X(n-2*M+k-1);
        end
        m(i)=m(i)/(2*M+1);
        Y(i)=X(i)-m(i);
    end
else
    print('数据长度小于滑动段长度*2+1，无法计算！');
end



