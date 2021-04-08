function r_rel = nav_lr_routine(w_in)
global env_feat cpm mpr

loc0 = [1000 500];
rwh = [];
for ii = 1:5
agent_generate_lr
run_nav_update_lr
rwh = [rwh rwd];
end

rf = .8; % regularization factor
r_rel = -mean(rwh)+sum(abs(w_in))*rf;