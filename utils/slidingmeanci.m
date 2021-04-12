function [xout,yout,seout,ciout] = slidingmeanci(xin,yin,twin,dx,doboot)
% this version assume xin is continuous variable and not sorted, may work
% for sorted matrices too
if isempty(xin)
    xin = 1:length(yin);
end

xout = (nanmin(xin)+(dx/2)):dx:nanmax(xin); % use bin center as x values
wnum = length(xout);
yout = nan(1,wnum);
seout = nan(1,wnum);
ciout = nan(2,wnum);

ops = statset('UseParallel',true);
% a;
parfor wi = 1:wnum
%     centered smoothing window
    inds = find(xin>=(xout(wi)-.5*twin)&...
        xin<(xout(wi)+.5*twin));
    medd = nanmean(yin(inds));
    se = nanstd(yin(inds))/sqrt(length(inds));
    bci = [nan;nan];
    if doboot
        if length(inds)>1
            bci = bootci(100,{@nanmean,yin(inds)},'Options',ops);
        else
            bci = [medd;medd];
        end
    end
    yout(wi) = medd;
    seout(wi) = se;
    ciout(:,wi) = bci;
    
end