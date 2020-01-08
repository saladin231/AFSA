function [next] = prey(i,j)
% 返回第i代第j条的觅食目标状态
    global TryNumber f AF;
    % 把当前状态的坐标设为最佳
    bestx = AF(j,1,i);
    besty = AF(j,2,i);
    
    % 捕食循环，找不到更好的状态则继续找，最多尝试TryNumber次
    t = 1;
    while t <= TryNumber
        t = t + 1;
        preyNext = randPositionInVisual(AF(j,1,i),AF(j,2,i));
        if f(preyNext(1),preyNext(2)) > f(AF(j,1,i),AF(j,2,i))
            bestx = preyNext(1);
            besty = preyNext(2);
            break;
        end
    end
    
    % 如果到这里还没找到更好的状态，则返回一个随机状态，否则返回找到的状态
    if bestx == AF(j,1,i) && besty == AF(j,2,i)
        next = randPositionInVisual(AF(j,1,i),AF(j,2,i)); 
    else
        next = [bestx besty];
    end
end

