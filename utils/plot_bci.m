function plot_bci(bx,bci,bmn,pclr,mclr,lstl)
bl = size(bci,2); bn = size(bci,1);
if isempty(bx)
   bx = 1:bl;
end
px = bx([1:bl bl:-1:1]); 

switch bn
    case 2
        py = [bci(1,:) bci(2,end:-1:1)];
    case 1
        bl = bmn-bci; bh = bmn+bci;
        py = [bl bh(end:-1:1)];
end

di = isnan(py); py(di) = []; px(di) = [];
patch(px,py,pclr,'edgecolor','none','facealpha',.6) % 'edgecolor','none',

if isempty(mclr)
    mclr = pclr;
end

if isempty(lstl)
    lstl = '-';
end

if ~isempty(bmn)
    hold all
   plot(bx,bmn,'linestyle',lstl,'color',mclr,'linewidth',1.5)
end