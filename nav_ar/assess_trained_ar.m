%% test trained nn agent on training and novel environments
simOptions = rlSimulationOptions('MaxSteps',1500);
sbflg = 0;
rng('shuffle')

% trainingn env
agp_tr =[];
for tti = 1:50
%     env.iniloc = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
    % loc0 = [300 500];
    experience = sim(env,agent,simOptions);
    rwd = sum(experience.Reward.Data);
    nt = length(env.Logsig.act_h);
    rt = sum(env.Logsig.act_h);
    
    agp_tr = [agp_tr;[nt rt rwd]];
end

figure(40);clf;hold all
subplot 221;hist(agp_tr(:,3),15)
subplot 222;hist(agp_tr(:,1),15)
%% test env
pbl = 0;
env_generate
env.env_feat = env_feat;

agp_tt =[];
sbflg = 1;
for tti = 1:5
    env_generate
    env.env_feat = env_feat;

    for ri = 1:16
        iniloc = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
        % loc0 = [300 500];
            experience = sim(env,agent,simOptions);
    rwd = sum(experience.Reward.Data);
    nt = length(env.Logsig.act_h);
    rt = sum(env.Logsig.act_h);
    
    agp_tt = [agp_tt;[nt rt rwd]];
    end
end
figure(40)
subplot 223;hist(agp_tt(:,3),15)
subplot 224;hist(agp_tt(:,1),15)
%%
dat = agp_tr(:,3);
agrm.rmd = nanmedian(dat);
agrm.rci = bootmedian(100,dat);
dat = agp_tr(:,1);
agrm.tmd = nanmedian(dat);
agrm.tci = bootmedian(100,dat);

dat = agp_tt(:,3);
agnt.rmd = nanmedian(dat);
agnt.rci = bootmedian(100,dat);
dat = agp_tt(:,1);
agnt.tmd = nanmedian(dat);
agnt.tci = bootmedian(100,dat);

figure(41);clf;hold all
bmn = [agrm.rmd agnt.rmd];
bci = [agrm.rci agnt.rci];
bx = []; pclr = 'b'; bw = .6; bbol = 1;
plot_bcibar(bx,bci,bmn,pclr,[],[],bw,bbol)

%% save agent test performance
formatOut = 'ddhhmm';
dstr = datestr(now,formatOut);
save([dtpath 'agtperfs\agtAR_perf' dstr '.mat'],...
    'envfile','cpm','mpr','agp_tr','agrm',...
    'agp_tt','agnt')
