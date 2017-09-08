function RandTraffic = makeData(N,WeightType,Distance,xlsdata4)
%% 输入“车辆的个数N”

% [~,~,xlsdata1] = xlsread('InitInfo.xlsx','车型数量');
% N = cell2mat(xlsdata1(2,2:end));

%% 输入“车重的分布类型和参数”
% 第一列代表分布类型：1表示对数正态；2代表正态分布；3代表双峰正态；
% 第二列代表车重均值
% 第三列代表车重方差
% 第四列代表车重最小值
% 第五列代表车重最大值
% [~,~,xlsdata2] = xlsread('InitInfo.xlsx','车重参数');
% WeightType = cell2mat(xlsdata2(2:end,2:end));

%% 输入“车量间距的分布类型和参数”
% 第一列代表分布类型：1表示对数正态；2代表正态分布；
% 第二列代表距离均值
% 第三列代表距离方差
% [~,~,xlsdata3] = xlsread('InitInfo.xlsx','车距参数');
% Distance = cell2mat(xlsdata3(2,1:end));


%% 6种车辆的信息初始化，按照给定条件列出不同汽车每隔0.1距离上的重量比例分布

% [~,~,xlsdata4] = xlsread('InitInfo.xlsx','车形参数');
clear Car;
d = 0.1;
for k = 1:7
    % 小客车
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

%% 依据车重信息产生个体车辆重量
TotalCarInfo = [];
for i = 1:length(N)
    %对数正态
    if WeightType(i,1) == 1
        %单位转换为KN
        WeigthInfo = lognrnd(WeightType(i,2),WeightType(i,3),[N(i),1])*10;
        % WeigthInfo = lognrnd(WeightType(i,2),WeightType(i,3),[N(i),1]);
    %正态分布
    elseif WeightType(i,1) == 2
        %单位转换为KN
        WeigthInfo = normrnd(WeightType(i,2),WeightType(i,3),[N(i),1])*10;
        % WeigthInfo = normrnd(WeightType(i,2),WeightType(i,3),[N(i),1]);
    %双峰正态
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
        %单位转换为KN
        WeigthInfo = x*10;
        % WeigthInfo = x;
    end
    %数据范围限制
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

%% 产生车辆间距信息
%对数正态
if Distance(1) == 1
    DistanceInfo = lognrnd(Distance(2),Distance(3),[sum(N)-1,1]);
%正态分布 
elseif Distance(1) == 2
    DistanceInfo = normrnd(Distance(2),Distance(3),[sum(N)-1,1]);
end
%数据范围限制
DistanceInfo = max(DistanceInfo,Distance(5));
DistanceInfo = min(DistanceInfo,Distance(4));
%% 产生随机数让车辆重新排序;
[~,sortId] = sort(rand(sum(N),1));

RandCarInfo = TotalCarInfo(sortId,:);

%% 随机车流的产生
RandTraffic = [];
for i = 1:length(RandCarInfo(:,1))
    RandTraffic = [RandTraffic;RandCarInfo{i,2}.Weigth*RandCarInfo{i,1}];
    if i ~= length(RandCarInfo(:,1))
        RandTraffic = [RandTraffic;zeros(round(DistanceInfo(i)/d),1)];
    end
end

