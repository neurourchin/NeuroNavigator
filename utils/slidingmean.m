function [yout] = slidingmean(xin,yin,twin,pos)
% pos = 1-forward, 0-centered, -1-trailing
% assuming xin increasing and equally spaced
if isempty(xin)
    xin = 1:length(yin);
end
    yout = []; %xout = [];
parfor wi = 1:length(xin) % parfor
    switch pos
        case 1
            inds = find(xin>=(xin(wi))&xin<(xin(wi)+twin));
        case 0
            inds = find(xin>=(xin(wi)-twin/2)&xin<(xin(wi)+twin/2));
        case -1
            inds = find(xin>(xin(wi)-twin)&xin<=(xin(wi)));
    end
    
    yvals  = yin(inds);
    yout(wi) = nanmedian(yvals);
%     xout(wi) = xin(wi);
end
% w