cc_st = nan(1,cpm.cn);
for ti = 1:cpm.cn
    cc_st(ti) = env_feat.c(ti).mp(round(loc_c(2)-cpm.ysft),...
        round(loc_c(1)-cpm.xsft));
end
cu_h = [cu_h;cc_st]; % store env states into state history, not available ot agent
cu_buf = [cu_buf;cc_st]; % recent environ state buffer, available to agent
cu_buf = cu_buf((end-1):end,:);