function xto = runeemod(xt0,mpr,ninp,tn)
xt = xt0;

for ti = 2:tn
    cx = xt(end,:);
    xo = eefun(cx(1),cx(2),ninp,mpr);
    dxa = [xo.dx1 xo.dx2]+mpr.nsf*[normrnd(0,1,1,2)];
    xtnw = max(0,(cx+dxa*mpr.dt));
    xt = [xt;xtnw];
end

xto = xt;