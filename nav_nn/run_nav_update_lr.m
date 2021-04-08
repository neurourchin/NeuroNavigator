% simulation params
% load([dtpath 'envdata_tmp.mat'],'env_feat')
% nvparams92620
lron = 0;
navt = 1;
xbd = env_feat.crdx([1 end]);
ybd = env_feat.crdy([1 end]);
rwd = 0;

% run simulation
while 1
    agent_update
    env_update_nn
    
    rwd = rwd-.1-.1*eout;
    stpflg = nav_checkstop(loc_h(end,:)-[cpm.xsft cpm.ysft],env_feat);
       
    navt = navt+1;
    if navt>1500
        break
    end
    
    if stpflg
        rwd = rwd+330;
        ss_in = s_input;
        break
    end
end

% % ea_visualizer
% % drawnow limitrate