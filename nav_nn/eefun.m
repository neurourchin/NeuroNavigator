function xo = eefun(x1,x2,ninp,mpr)
% parse params
tau1 = mpr.tau(1); tau2 = mpr.tau(2);
k12 = mpr.k(1); k21 = mpr.k(2); 
n12 = mpr.n(1); n21 = mpr.n(2); %n22 = prm.n(2,2);
b1 = mpr.b(1);
b2 = mpr.b(2); %r2 = prm.r(2);
bs1 = mpr.bs(1); bs2 = mpr.bs(2); % basal prod rates
% parse inputs
I = ninp; ic = mpr.ic;

nx1 = b1*sig(k12-ic,n12,-x2)+bs1;
nx2 = b2*sig(k21-ic-I,n21,-x1)+bs2;

dx1 = (1/tau1)*(-x1+nx1);
dx2 = (1/tau2)*(-x2+nx2); 

xo.nx1 = nx1; xo.nx2 = nx2;
xo.dx1 = dx1; xo.dx2 = dx2;
