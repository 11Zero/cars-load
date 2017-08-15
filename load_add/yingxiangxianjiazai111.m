%随机荷载加载影响线程序
%可自定义影响线，桥长，以0.1m为一个步长
clc,clear
qiaochang=0:0.1:25;  %桥长为30m，以0.1m为一个单位
% yingxiangxian=-0.01.*qiaochang.^2+qiaochang;   %桥梁跨中弯矩M影响线方程
p1=0;
%p1=-0.00804755368742752;
p2=0.0907112783108678;
p3=-0.0171400876861163;
p4=-2.84774382307739e-6;
yingxiangxian=p1+p2.*qiaochang+p3.*qiaochang.^1.5+p4.*qiaochang.^3;   %桥梁跨中弯矩M影响线方程
figure(1); plot(qiaochang,yingxiangxian,'r')
hezai=xlsread('RandTraffic.xlsx','Sheet1'); %读入EXCEL表格的随机荷载，单位KN
hezai=hezai';
zhi=zeros(1,(length(hezai)+length(qiaochang)));
for i=1:length(zhi)
    if i<=length(qiaochang)
        zhi(i)=sum(hezai((length(hezai)-i+1):length(hezai)).*yingxiangxian(1:i));
    elseif (length(qiaochang)<i)&&(i<=length(hezai))
        m=length(hezai)-i+1;
        n=length(hezai)-i+length(qiaochang);
        zhi(i)=sum(hezai(m:n).*yingxiangxian);
    else
         m=hezai((i-length(qiaochang)):length(hezai));
         n=yingxiangxian((i-length(hezai)):length(qiaochang));
         zhi(i)=sum(m.*n);
    end
end
heng=1:(length(qiaochang)+length(hezai));
figure(2);plot(heng,zhi) 
xlabel('荷载效应长度');ylabel('荷载效应值KN*m');
Maxzhi=max(zhi)   %单位KN*m
figure(3);hist(zhi,80);
xlabel('荷载效应值');ylabel('频数');
figure(4);
[ni,ak]=hist(zhi,80);
fi=ni/length(zhi);
bar(ak,fi);
xlabel('荷载效应值');ylabel('频率');