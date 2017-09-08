function RandTraffic = makeData(N,WeightType,Distance,xlsdata4)
%% ���롰�����ĸ���N��

% [~,~,xlsdata1] = xlsread('InitInfo.xlsx','��������');
% N = cell2mat(xlsdata1(2,2:end));

%% ���롰���صķֲ����ͺͲ�����
% ��һ�д���ֲ����ͣ�1��ʾ������̬��2������̬�ֲ���3����˫����̬��
% �ڶ��д����ؾ�ֵ
% �����д����ط���
% �����д�������Сֵ
% �����д��������ֵ
% [~,~,xlsdata2] = xlsread('InitInfo.xlsx','���ز���');
% WeightType = cell2mat(xlsdata2(2:end,2:end));

%% ���롰�������ķֲ����ͺͲ�����
% ��һ�д���ֲ����ͣ�1��ʾ������̬��2������̬�ֲ���
% �ڶ��д�������ֵ
% �����д�����뷽��
% [~,~,xlsdata3] = xlsread('InitInfo.xlsx','�������');
% Distance = cell2mat(xlsdata3(2,1:end));


%% 6�ֳ�������Ϣ��ʼ�������ո��������г���ͬ����ÿ��0.1�����ϵ����������ֲ�

% [~,~,xlsdata4] = xlsread('InitInfo.xlsx','���β���');
clear Car;
d = 0.1;
for k = 1:7
    % С�ͳ�
    L0 = cell2mat(xlsdata4(k*2,3:end));
    W0 = cell2mat(xlsdata4(k*2+1,3:end));
    L0(isnan(L0)) = [];
    W0(isnan(W0)) = [];
    Car(k).Length = (0:d:sum(L0))';
    Car(k).Weigth = zeros(size(Car(k).Length));
    Car(k).Weigth(1) = W0(1);
    
    for i = 1:length(L0)
        Car(k).Weigth(1+round(sum(L0(1:i))/d)) = W0(i+1);
    end
end

%% ���ݳ�����Ϣ�������峵������
TotalCarInfo = [];
for i = 1:length(N)
    %������̬
    if WeightType(i,1) == 1
        %��λת��ΪKN
        WeigthInfo = lognrnd(WeightType(i,2),WeightType(i,3),[N(i),1])*10;
        % WeigthInfo = lognrnd(WeightType(i,2),WeightType(i,3),[N(i),1]);
    %��̬�ֲ�
    elseif WeightType(i,1) == 2
        %��λת��ΪKN
        WeigthInfo = normrnd(WeightType(i,2),WeightType(i,3),[N(i),1])*10;
        % WeigthInfo = normrnd(WeightType(i,2),WeightType(i,3),[N(i),1]);
    %˫����̬
    elseif WeightType(i,1) == 3
        r = WeightType(i,8);
        mu1 = WeightType(i,2);
        sigma1 = WeightType(i,3);
        mu2 = WeightType(i,6);
        sigma2 = WeightType(i,7);
        x=zeros(N(i),1);
        for m=1:N(i)
            r1=rand;
            x(m)=(mu2+sigma2*randn)*heaviside(r1-r)+(mu1+sigma1*randn)*heaviside(r-r1);
        end
        %��λת��ΪKN
        WeigthInfo = x*10;
        % WeigthInfo = x;
    end
    %���ݷ�Χ����
    WeigthInfo = max(WeigthInfo,WeightType(i,5)*10);
    WeigthInfo = min(WeigthInfo,WeightType(i,4)*10);
    for k = 1:N(i)
        if isempty(TotalCarInfo)
            TotalCarInfo{1,1} =  WeigthInfo(k);
            TotalCarInfo{1,2}  =  Car(i);
            TotalCarInfo{1,3} =  i;
        else
            len = length(TotalCarInfo(:,1));
            TotalCarInfo{len+1,1} =  WeigthInfo(k) ;
            TotalCarInfo{len+1,2} =  Car(i);
            TotalCarInfo{len+1,3} = i;
        end
    end
end

%% �������������Ϣ
%������̬
if Distance(1) == 1
    DistanceInfo = lognrnd(Distance(2),Distance(3),[sum(N)-1,1]);
%��̬�ֲ� 
elseif Distance(1) == 2
    DistanceInfo = normrnd(Distance(2),Distance(3),[sum(N)-1,1]);
end
%���ݷ�Χ����
DistanceInfo = max(DistanceInfo,Distance(5));
DistanceInfo = min(DistanceInfo,Distance(4));
%% ����������ó�����������;
[~,sortId] = sort(rand(sum(N),1));

RandCarInfo = TotalCarInfo(sortId,:);

%% ��������Ĳ���
RandTraffic = [];
for i = 1:length(RandCarInfo(:,1))
    RandTraffic = [RandTraffic;RandCarInfo{i,2}.Weigth*RandCarInfo{i,1}];
    if i ~= length(RandCarInfo(:,1))
        RandTraffic = [RandTraffic;zeros(round(DistanceInfo(i)/d),1)];
    end
end

