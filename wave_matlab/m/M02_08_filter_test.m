%FIR�˲������飨1.4.7.3�ڣ�����ͼ1.15-1.22���Լ�ͼ1.11b��1.13b��
%�����ź�:������Ϊ200sps�Ľ�Ծ�ź�
clear

%������λ�˲���
load M02_firln02.h
fir_temp=M02_firln02;
rate=fir_temp(1)
T=1/rate
Nfir=fir_temp(2)     %�˲���ϵ������
for i=1:Nfir
    firl(i)=fir_temp(i+2);
end
%���ɼ��������ź�
Nzero=200;
for i=1:Nzero
    xstep(i)=0;
end
None=300
for i=1:None
   % xstep(Nzero+i)=1;
     xstep(Nzero+i)=sin(2*pi*10*i*T)+0.5*sin(2*pi*20*i*T+pi/2); %���������źŵ���
end
N=length(xstep)
%�޻��˲�
yl=zeros(1,N)
for i=Nfir+1:N       
    for j=1:Nfir
        yl(i)=yl(i)+firl(j)*xstep(i-j+1);
    end
end

figure(1)

subplot(2,1,1)
plot(xstep)
subplot(2,1,2)
plot(yl)
title('moving sum')
%��С��λ�˲���
load M02_firm02.h
fir_temp=M02_firm02;
rate=fir_temp(1)
T=1/rate
Nfir=fir_temp(2)
for i=1:Nfir
    firm(i)=fir_temp(i+2);
end
N=length(xstep)
for i=1:N
    ym(i)=0;
end
for i=Nfir+1:N
    for j=1:Nfir
        ym(i)=ym(i)+firm(j)*xstep(i-j+1);
    end
end

figure(2)
subplot(2,1,1)
plot(xstep)
subplot(2,1,2)
plot(ym)
%�źŻָ�
[q,r] = deconv(yl,firl);   %������λ
figure(3)
subplot(2,1,1)
plot(yl)
subplot(2,1,2)
plot(q)
[q,r] = deconv(ym,firm);  %��С��λ
figure(4)
subplot(2,1,1)
plot(ym)
subplot(2,1,2)
plot(q)
%��Matlab���߻���Ӧ����
figure(5)
freqz(firl,1)   %������λFIR
figure(6)
freqz(firm,1)  %��С��λFIR
% ʹ��Matlab����
figure(7)
[yl,zf0]=filter(firl,1,xstep);   %������λFIR�˲���
zf0   %�˲�������״̬
zf0l=length(zf0)
subplot(2,1,1)
plot(xstep)
subplot(2,1,2)
plot(yl)
title('filter')
figure(8)
yll=filtfilt(firl,1,xstep);%�����˲�

subplot(2,1,1)
plot(xstep)
subplot(2,1,2)
plot(yll)
title('filtfilt')
%����ʽ��2.97�������˲�������״̬zf
b=firl;
a=1;
Nb=length(b)
La=length(a)
M=max(Nb,La)-1
for m=1:M
    zf(m)=0;
    if m<Nb
    for i=m:Nb-1
        zf(m)=zf(m)+b(i+1)*xstep(N+m-i);
    end
    end
    if La>1&m+1<La
    for i=m+1:La-1
        zf(m)=zf(m)+a(i+1)*y(N+m-i+1);
    end
    end
    end
    zf(m)=zf(m)/a(1);
zfl=length(zf)
zf
figure(9)    
plot(zf,'r');hold on   %�������zf
plot(zf0,'b')              %��[y,zf0]=filter(b,a,x)�õ���
%���һ��
%�����˲�������״̬��Ϊ��һ���ź��˲��ĳ�ʼ״̬

N1one=300
for i=1:N1one
    %xstep1(i)=1;
     xstep1(i)=sin(2*pi*10*i*T)+0.5*sin(2*pi*20*i*T+pi/2); %���������źŵ���
end
N1zero=200;
for i=1:N1zero
    xstep1(N1one+i)=0;
end
N1=length(xstep1)
N2=N+N1
%�����ź�����
x2(1:N)=xstep(1:N);
x2(N+1:N2)=xstep1(1:N1);
figure(10)
plot(x2)
[y2,zf2]=filter(b,a,x2); %���κ�Ϊһ���˲�
figure(11)
plot(y2)
figure(12)
plot(zf2)
%�������˲�����2�����õ�1�ε�zf1
[y21,zf1]=filter(b,a,xstep)
[y22,zf2]=filter(b,a,xstep1,zf1) %��2���õ�1�ε�zf��Ϊzi
y2(1:N)=y21(1:N);
y2(N+1:N2)=y22(1:N1);
figure(13)
plot(y2)
%���Կ���ͼ13��ͼ11һ��
[y22,zf2]=filter(b,a,xstep1)  %��2�β��õ�1�ε�zf��Ϊzi
y2(N+1:N2)=y22(1:N1);
figure(14)
plot(y2)   %������ε���������ν�
% ��ʽ��2.98�������1�ε�zf����Ϊ��2�ε�zi����ʽ��2.99�������2�ε��˲����
%����ʽ��2.98�������˲�������״̬zf
b=firl;
a=1;
Nb=length(b)
La=length(a)
M=max(Nb,La)-1
for m=1:M
    zf(m)=0;
    if m<Nb
    for i=m:Nb-1
        zf(m)=zf(m)+b(i+1)*xstep(N+m-i);
    end
    end
    if La>1&m+1<La
    for i=m+1:La-1
        zf(m)=zf(m)+a(i+1)*y(N+m-i+1);
    end
    end
    end
    zf(m)=zf(m)/a(1);
zfl=length(zf)
zf
figure(15)    
plot(zf,'r');hold on   %�������zf
% ʽ��2.99��
for k=1:M
    y1(k)=0;
    N11=min(k,Nb-1)
    if N11>0
    for i=1:N11
        y1(k)=y1(k)+b(i)*xstep1(k-i+1);
    end
    end
    L11=min(k,La-1)
    if L11>1
    for i=2:L11
        y1(k)=y1(k)-a(i)*y1(k-i+2);
    end
    end
    y1(k)=y1(k)/a(1);
            y1(k)=y1(k)+zf(k);
     end
    figure(16)
  N1
    for i=M+1:N1      
        y1(i)=0;
    for j=1:Nb
        y1(i)=y1(i)+b(j)*xstep1(i-j+1);
    end
    if La>1
    for j=2:La
        y1(i)=y1(i)-a(j)*y1(i-j+1);
    end
    end
    y1(i)=y1(i)/a(1);
    end
    subplot(2,1,1)
plot(xstep1,'r');%��2�������ź�
subplot(2,1,2)
    plot(y1)   %��2��������˲����ź�,�����˵�1�ε��˲�������״̬
%��������
y2(N+1:N2)=y1(1:N1);
figure(17)
plot(y2)
%���ӳɹ�