function [next] = moveto(x,y,nowx,nowy)
% 参数(x,y,nowx,nowy)表示（目标x坐标，目标y坐标，自已的x坐标，自己的y坐标）。返回一个向量，表示要沿着这个向量移动；若zero标识为1，表示目标位置和当前重合，不要移动
    global Step
    long = Step * rand();       % 随机选一个移动长度
%     % 越界处理
%     if x > 10
%         x = 10;
%     elseif x < -10
%         x = -10;
%     end
%     if y > 10
%         y = 10;
%     elseif y < -10
%         y = -10;
%     end
%     if nowx > 10
%         nowx = 10;
%     elseif nowx < -10
%         nowx = -10;
%     end
%     if nowy > 10
%         nowy = 10;
%     elseif nowy < -10
%         nowy = -10;
%     end
    zero = 0;
    n = ones(1,2);
    if x ~= nowx && y ~= nowy
        n = [x y] - [nowx nowy]; 
        n = n/norm(n);              % 向量除以它的模得到单位向量
        n = long * n;
        % 越界处理
        if nowx + n(1) > 10
            n(1) = 10 - nowx;
        elseif nowx + n(1) < -10
            n(1) = -10 - nowx;
        end
        if nowy + n(2) > 10
            n(2) = 10 - nowy;
        elseif nowy + n(2) < -10
            n(2) = -10 - nowy;
        end
    else
        zero = 1;
    end
    next = [n(1),n(2),zero];
end