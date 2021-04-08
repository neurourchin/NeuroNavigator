% Reset environment to initial state and return initial observation
function [iniobs, logsig] = nav_reset_dp()
global env_feat cpm loc0
% Reset agent initial location and query corresponding cue values.
cc_st = nan(1,cpm.cn);
for ti = 1:cpm.cn
    cc_st(ti) = env_feat.c(ti).mp(round(loc0(2)-cpm.ysft),...
        round(loc0(1)-cpm.xsft));
end

% Return initial environment state variables as logged signals.
logsig.cc_st = cc_st;
logsig.cc_h = cc_st;
logsig.loc_c = loc0;
logsig.loc_h = loc0;
% logsig.act_c = nan;
logsig.act_h = nan;
iniobs = logsig.cc_st;

end