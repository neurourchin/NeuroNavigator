%% test trained nn agent on training and novel environments

% trainingn env
env_generate_nn

agp_tr =[];
for tti = 1:50
    loc0 = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
    % loc0 = [300 500];
    agent_generate_lr
    run_nav_update_lr
    agp_tr = [agp_tr;[navt sum(st_h) rwd]];
end

figure(40);clf;hold all
subplot 221;hist(agp_tr(:,3),15)
subplot 222;hist(agp_tr(:,1),15)
%% test env
agp_tt =[];
sbflg = 1;
pbl = 0;
for tti = 1:5
    env_generate
    for ri = 1:16
        loc0 = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
        % loc0 = [300 500];
        agent_generate_lr
        run_nav_update_lr
        agp_tt = [agp_tt;[navt sum(st_h) rwd]];
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
        save([dtpath 'agtNN_perf' dstr '.mat'],...
            'envfile','cpm','mpr','agp_tr','agrm',...
            'agp_tt','agnt')
savfigr(plpath,['navnn_testpf' dstr '.mat'])