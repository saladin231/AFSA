disp('正在执行人工鱼群算法');

global AfNumber Visual Step Delta TryNumber AF f;

AfNumber = 100;
Visual = 8;
Step = 4;
Delta = 0.1;
TryNumber = 5;
MaxIteration = 50;

% 测试函数
% f = @(x,y) sin(sqrt(x.^2 + y.^2))./(sqrt(x.^2 + y.^2));
f = @(x,y) (1.5 - x + x.*y).^2 + (2.25 - x + x.*y.^2).^2 + (2.625 - x + x.*y.^3).^2;
% f = @(x,y) y.*sin(x) - x.*cos(y);

% 初始化第一代人工鱼群的状态(随机分布位置)
AF = ones(AfNumber,2,MaxIteration+1);           % 三维数组记录AF的数据：第一维代表第几条，第二维代表坐标，第三维代表第几代
for i = 1:AfNumber
    AF(i,1,1) = -10 + 20*rand();
    AF(i,2,1) = -10 + 20*rand();
end

% 计算每条第一代人工鱼的食物度
% AF_Food = ones(AfNumber,MaxIteration);      % 每一行对应一条AF，各列表示各代的食物度
% % for i = 1:AfNumber
% %     AF_Food(i,1) = f(AF(i,1,1),AF(i,2,1));
% % end

% 绘制实验测试函数图：
[a,b] = meshgrid(-10:0.1:10);
c = f(a,b);
figure('Name','实验测试函数');
mesh(a,b,c), xlabel('x坐标'), ylabel('y坐标'), zlabel('食物度');
colorbar;

figure('Name','实验测试函数');
mesh(a,b,c), xlabel('x坐标'), ylabel('y坐标'), zlabel('食物度');
view(2);
colorbar;

%绘制初始人工鱼分布图：
% figure('Name','人工鱼分布');
% mesh(a,b,c);
% colormap(gray);
% view(2);
% hold on;
% x = AF(:,1,1);
% y = AF(:,2,1);
% scatter(x,y,'filled');

% i代表第几代，j代表第几条
for i = 1:MaxIteration
    for j = 1:AfNumber
        next_p = prey(i,j);       % 捕食行为找到的下一个状态
        next_s = swarm(i,j);      % 聚群行为找到的下一个状态
        next_f = follow(i,j);     % 追尾行为找到的下一个状态
        er = evaluate(next_p,next_s,next_f);
        if er == 1
            % 聚群，更新下一代坐标
            next = moveto(next_s(1),next_s(2),AF(j,1,i),AF(j,2,i));
            if next(3) == 1
                AF(j,1,i+1) = AF(j,1,i);
                AF(j,2,i+1) = AF(j,2,i);
            else
                AF(j,1,i+1) = AF(j,1,i) + next(1);
                AF(j,2,i+1) = AF(j,2,i) + next(2);
            end
        elseif er == 2
            % 追尾，更新下一代坐标
            next = moveto(next_f(1),next_f(2),AF(j,1,i),AF(j,2,i));
            if next(3) == 1
                AF(j,1,i+1) = AF(j,1,i);
                AF(j,2,i+1) = AF(j,2,i);
            else
                AF(j,1,i+1) = AF(j,1,i) + next(1);
                AF(j,2,i+1) = AF(j,2,i) + next(2);
            end
        else
            % 觅食，更新下一代坐标
            next = moveto(next_p(1),next_p(2),AF(j,1,i),AF(j,2,i));
            if next(3) == 1
                AF(j,1,i+1) = AF(j,1,i);
                AF(j,2,i+1) = AF(j,2,i);
            else
                AF(j,1,i+1) = AF(j,1,i) + next(1);
                AF(j,2,i+1) = AF(j,2,i) + next(2);
            end
        end
    end
            
    % 绘图
    if mod(i-1,5) == 0
        figure('Name','人工鱼分布');
%         mesh(a,b,c);
%         shading interp;
%         colormap(gray);
%         view(2);
%         hold on;
        x = AF(:,1,i);
        y = AF(:,2,i);
        scatter(x,y,'filled');
    end
end

% % 计算每代每条工鱼的食物度
% AF_Food = ones(MaxIteration,AfNumber);      % 每行代表一代，每列代表一条
% for i = 1:MaxIteration
%     for j = 1:AfNumber
%         AF_Food(i,j) = f(AF(j,1,i),AF(j,2,i));
%     end
% end
% 
% % 计算各代的平均食物度，并绘图
% Average_Food = zeros(1,MaxIteration);
% for i = 1:MaxIteration
%     for j = 1:AfNumber
%         Average_Food(i) = Average_Food(i) + AF_Food(i,j);
%     end
%     Average_Food(i) = Average_Food(i)/AfNumber;
% end
% 
% xias = randperm(MaxIteration);              % 创建一个含MaxIteration个元素的一维数组，1~MaxIteration的每个整数出现一次
% sort(xias);                                 % 排序
% figure('Name','各代平均食物度');
% scatter(xias,Average_Food);
