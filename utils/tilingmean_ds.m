function [xout,yout] = tilingmean_ds(xin,yin,twin,ord)

if isempty(xin)
   xin = 1:length(yin); 
end

switch ord
    case 1 % forward starting from 1st of xin, report right bounds
        xout = xin(1):twin:xin(end);
        if (xin(end)-xout(end))>(twin/4)
            xout = [xout xin(end)];
        else
            xout(end) = xin(end);
        end
    case -1
        xout = xin(end):-twin:xin(1);
        xout = xout(end:-1:1);
        if (xout(1)-xin(1))>(twin/4)
            xout = [xin(1) xout];
        else
            xout(1) = xin(1);
        end
end

yout = []; 
for wi = 1:(length(xout)-1)
    inds = find(xin>=xout(wi)&xin<=xout(wi+1));
    if length(inds)>twin/4
        medd = nanmean(yin(inds));
        yout = [yout medd];
    end
end
