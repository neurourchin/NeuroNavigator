function [nextobs,rwd,dnflg,logsig] = nav_step(act,logsig)
% Custom step function to construct cart-pole environment for the function
% name case.
global env_feat cpm rwset

% Execute movement
loc_c = logsig.loc_h(end,:) + cpm.spd*[cos(act) sin(act)];
% enforce boundary conditions
xbd = env_feat.crdx([1 end]);
ybd = env_feat.crdy([1 end]);
loc_c(1) = min(xbd(2),(max(xbd(1),loc_c(1))));
loc_c(2) = min(ybd(2),(max(ybd(1),loc_c(2))));

% Querie cue values
cc_st = nan(1,cpm.cn);
for ti = 1:cpm.cn
    cc_st(ti) = env_feat.c(ti).mp(round(loc_c(2)-cpm.ysft),...
        round(loc_c(1)-cpm.xsft));
end

% Update state log
logsig.cc_st = cc_st;
logsig.cc_h = [logsig.cc_h;(cc_st(:))'];
logsig.loc_c = loc_c;
logsig.loc_h = [logsig.loc_h;(loc_c(:))'];
logsig.act_h = [logsig.act_h;act];

% Assign cue values to next observation.
nextobs = logsig.cc_st;

% Check terminal condition.
dnflg = nav_checkstop(loc_c-[cpm.xsft cpm.ysft],env_feat);

% Get reward, or pay cost.
if dnflg
    rwd = rwset(1);
else
    rwd = rwset(2);
end

end