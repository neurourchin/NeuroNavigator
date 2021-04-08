% simulation params
% load([dtpath 'envdata_tmp.mat'],'env_feat')
% nvparams92620
lron = 0;
navt = 1;
xbd = env_feat.crdx([1 end]);
ybd = env_feat.crdy([1 end]);

% run simulation
while 1
    agent_update
    env_update_nn
    
    if ~mod(navt,45)
    ea_visualizer
    drawnow limitrate
    end
    
    if lron
        learn_update
    end
    
    navt = navt+1;
    if navt>2500
        break
    end
    
    stpflg = nav_checkstop(loc_h(end,:)-[xsft ysft],env_feat);
    if stpflg
        break
    end
end