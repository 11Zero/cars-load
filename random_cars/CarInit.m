%% 6种车辆的信息初始化，按照给定条件列出不同汽车每隔0.1距离上的重量比例分布

[~,~,xlsdata4] = xlsread('InitInfo.xlsx','车形参数');

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
