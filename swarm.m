function [next] = swarm(i,j)
% 获取第i代第j条的聚群目标状态和视野内伙伴数nf，若nf为0，说明视野内没有伙伴
    global AF AfNumber Visual;
    nf = 0;     % 视野内的目标伙伴数量初始值为0
    % 下面的循环寻找视野内伙伴时要排除掉本身，分三种情况
    if j == 1
        for a = 2:AfNumber
            if sqrt((AF(j,1,i) - AF(a,1,i))^2 + (AF(j,2,i) - AF(a,2,i))^2) <= Visual
                nf = nf +1;
                friend(nf,1) = AF(a,1,i);
                friend(nf,2) = AF(a,2,i);
            end
        end
    elseif j == AfNumber
        for a = 1:AfNumber-1
            if sqrt((AF(j,1,i) - AF(a,1,i))^2 + (AF(j,2,i) - AF(a,2,i))^2) <= Visual
                nf = nf +1;
                friend(nf,1) = AF(a,1,i);
                friend(nf,2) = AF(a,2,i);
            end
        end
    else
        for a = 1:j-1
            if sqrt((AF(j,1,i) - AF(a,1,i))^2 + (AF(j,2,i) - AF(a,2,i))^2) <= Visual
                nf = nf +1;
                friend(nf,1) = AF(a,1,i);
                friend(nf,2) = AF(a,2,i);
            end
        end
        for a = j+1:AfNumber
            if sqrt((AF(j,1,i) - AF(a,1,i))^2 + (AF(j,2,i) - AF(a,2,i))^2) <= Visual
                nf = nf +1;
                friend(nf,1) = AF(a,1,i);
                friend(nf,2) = AF(a,2,i);
            end
        end
    end
    
    % 计算伙伴中心坐标
    friend_position(1) = 0;
    friend_position(2) = 0;
    xc = 0;
    yc = 0;
    if nf ~= 0
        for a = 1:nf
            friend_position(1) = friend_position(1) + friend(a,1);
            friend_position(2) = friend_position(2) + friend(a,2);
        end
        xc = friend_position(1)/nf;
        yc = friend_position(2)/nf;
    end
    next = [xc,yc,nf];
end

