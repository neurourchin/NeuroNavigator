function [bm,bci] = make_barpltm(bx,bdat,clrs,fid,bw,em)
% bdat clrs are cell vars
bn = length(bdat);
if isempty(bx)
    bx = 1:bn;
end
if ~isempty(fid)
    figure(fid);clf;hold all
else
    hold all
end
if isempty(bw)
    bw = .5;
end

for bi = 1:bn
    cbd = bdat{bi}; cbd = cbd(:);
    bm(bi) = nanmedian(cbd);
    switch em
        case 1
            bci(:,bi) = bootmedian(200,cbd);
            bce = [bm(bi)-bci(1,bi),bci(2,bi)-bm(bi)];
        case 2
            be = std(cbd)/sqrt(length(cbd));
            bci(:,bi) = [bm(bi)-be;bm(bi)+be];
            bce = [be be];
        case 3 % for already bootstrapped samples
            bci(:,bi) = prctile(cbd,[2.5 97.5]);
            bce = [bm(bi)-bci(1,bi),bci(2,bi)-bm(bi)];
    end
    if bw>0
        bar(bx(bi),bm(bi),'barwidth',bw,'facecolor',clrs{min(bi,length(clrs))})
    end
    if bi==1; bce(2)=bce(2)-.02;end
        if bi==2; bce(1) = bce(1)-.03;end
    errorbar(bx(bi),bm(bi),bce(1),bce(2),'k.','linewidth',1)
    hold all
end

plotstandard
set(gca,'xlim',[bx(1)-.7 bx(end)+.7],'xtick',bx)
