%������ؼ���Ӱ���߳���
%���Զ���Ӱ���ߣ��ų�����0.1mΪһ������
clc,clear
qiaochang=0:0.1:25;  %�ų�Ϊ30m����0.1mΪһ����λ
% yingxiangxian=-0.01.*qiaochang.^2+qiaochang;   %�����������MӰ���߷���
p1=0;
%p1=-0.00804755368742752;
p2=0.0907112783108678;
p3=-0.0171400876861163;
p4=-2.84774382307739e-6;
yingxiangxian=p1+p2.*qiaochang+p3.*qiaochang.^1.5+p4.*qiaochang.^3;   %�����������MӰ���߷���
figure(1); plot(qiaochang,yingxiangxian,'r')
hezai=xlsread('RandTraffic.xlsx','Sheet1'); %����EXCEL����������أ���λKN
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
xlabel('����ЧӦ����');ylabel('����ЧӦֵKN*m');
Maxzhi=max(zhi)   %��λKN*m
figure(3);hist(zhi,80);
xlabel('����ЧӦֵ');ylabel('Ƶ��');
figure(4);
[ni,ak]=hist(zhi,80);
fi=ni/length(zhi);
bar(ak,fi);
xlabel('����ЧӦֵ');ylabel('Ƶ��');