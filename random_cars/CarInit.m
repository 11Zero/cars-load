%% 6�ֳ�������Ϣ��ʼ�������ո��������г���ͬ����ÿ��0.1�����ϵ����������ֲ�

[~,~,xlsdata4] = xlsread('InitInfo.xlsx','���β���');

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
