function eout = mc2act(mout,mpr)
% determine exploration vs exploitation state
if mout.nnh(end,1)>mpr.nth
    eout = 0; % enter dwelling if Xt(1)/NSM rises above nth
else
    eout = 1;
end
