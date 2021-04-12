function [xout,yout] = tilingmean(xin,yin,twin)

if isempty(xin)
   xin = 1:length(yin); 
end

wnum = ceil((xin(end)-xin(1)+1)/twin);

yout = []; xout = [];
for wi = 1:wnum
    
    inds = find(xin>=(xin(1)+twin*(wi-1))&...
        xin<(xin(1)+twin*wi));
    medd = nanmean(yin(inds));
    ytmp = medd*ones(1,length(inds));
    yout = [yout ytmp];
    xout = [xout xin(inds)];
end
% w