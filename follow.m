function [next] = follow(i,j)
% 返回第i代第j条的追尾目标状态、伙伴数量nf、是否有适合追尾目标（0表示没有，1表示有）
    global AF AfNumber Visual f Delta;
    % 先把食物度最高的伙伴设为自身，nf设为-1，因为下面的nf计数会把自身统计进去，抵消为0
    bestx = AF(j,1,i);
    besty = AF(j,2,i);
    nf = -1;
    ifHaveTarget = 0;
    
    for a = 1:AfNumber
        if sqrt((AF(j,1,i) - AF(a,1,i))^2 + (AF(j,2,i) - AF(a,2,i))^2) <= Visual
            nf = nf + 1;
        end
    end
    
    for a = 1:AfNumber
        if sqrt((AF(j,1,i) - AF(a,1,i))^2 + (AF(j,2,i) - AF(a,2,i))^2) <= Visual && (f(AF(a,1,i),AF(a,2,i)))/nf > Delta * f(bestx,besty)
            bestx = AF(a,1,i);
            besty = AF(a,2,i);
            ifHaveTarget = 1;
        end
    end
    
    next = [bestx,besty,nf,ifHaveTarget];
end
