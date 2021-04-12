function [xout,yout,seout,ciout] = tilingmeanci(xin,yin,twin,doboot)
% this version assume xin is continuous variable and not sorted, may work
% for sorted matrices too
if isempty(xin)
    xin = 1:length(yin);
end

wnum = ceil((max(xin)-min(xin)+.1)/twin);
xout = min(xin)-twin/2+twin*(1:wnum); % use bin center as x values
yout = nan(1,wnum);
seout = nan(1,wnum);
ciout = nan(2,wnum);

% a
parfor wi = 1:wnum
%     wi
    inds = find(xin>=(xout(1)+twin*(wi-1))&...
        xin<(xout(1)+twin*wi));
    medd = nanmean(yin(inds));
    se = nanstd(yin(inds))/sqrt(length(inds));
    bci = [nan;nan];
    if doboot
        if length(inds)>1
            bci = bootci(100,@nanmean,yin(inds));
        else
            bci = [medd;medd];
        end
    end
    yout(wi) = medd;
    seout(wi) = se;
    ciout(:,wi) = bci;
    
end
% w