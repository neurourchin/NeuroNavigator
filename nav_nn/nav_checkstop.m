function stpflg = nav_checkstop(cloc,env_feat)
% check if agent has entered any food patch
stpflg = 0;
for fi = 1:length(env_feat.f)
    if (env_feat.f(fi).mp(round(cloc(2)),round(cloc(1))))>0
        stpflg = 1;
        break
    end
end