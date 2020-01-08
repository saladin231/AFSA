function [ax] = randPositionInVisual(x0,y0)
% 获取视野内的一个随机坐标
    global Visual;
    r = Visual * rand();        % 随机获取一个不超过视野的半径
    seta = 2 * pi * rand();     % 随机获取一个角度
    x = x0 + r * cos(seta);     % 获得x坐标
    y = y0 + r * sin(seta);     % 获得y坐标
    
    % 越界处理
    if x > 10
        x = 10;
    elseif x < -10
        x = -10;
    end
    
    if y > 10
        y = 10;
    elseif y < -10
        y = -10;
    end
    
    ax = [x,y];
end

