function [pf,xi,ct,xc] = kdhist(dat,bw,cpf)
if ~isempty(bw)
[pf,xi] = ksdensity(dat,'bandwidth',bw); 
else
    [pf,xi] = ksdensity(dat); 
end
pf = cpf*pf/sum(pf);
[ct,xc] = hist(dat,10);
bar(xc,ct(:)/sum(ct),'edgecolor','none');
hold all;plot(xi(xi>0),pf(xi>0),'r','linewidth',1.5); 
trm = median(dat); plot(trm*[1 1],[0 1],'r--','linewidth',1.5)
% set(gca,'ylim',[0 .33],'yticklabel','','xlim',[-0.5 21])
% plotstandard
