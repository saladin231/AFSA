function [result] = evaluate(p,s,fo)
% 根据p、s、fo三个参数估算最优行动，返回0表示捕食，返回1表示聚群，返回2表示追尾。p参数：觅食操作的目标状态；s参数：聚群行为的目标状态及伙伴数量；fo参数：追尾行为的目标状态及伙伴数量
    global f Delta;
    result = 0;
    
    if s(3) ~= 0 && fo(4) == 0
        if f(s(1),s(2))/s(3) > Delta * f(p(2),p(2))
            result = 1;
        end
    elseif s(3) == 0 && fo(4) ~= 0
        if f(fo(1),fo(2))/fo(3) > Delta * f(p(2),p(2))
            result = 2;
        end
    elseif s(3) ~= 0 && fo(4) ~= 0
        if f(s(1),s(2)) > f(fo(1),fo(2))
            result = 1;
        else 
            result = 2;
        end
    end
end
