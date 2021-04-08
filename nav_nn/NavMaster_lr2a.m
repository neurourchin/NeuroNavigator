% general framework for simulating navigation in a feature (i.e. sensory
% cue) based environment
% Components:
% 1. environment definition
% 3. environment update rule
% 2. agent definition
% 4. agent-environment update rule
% 4-2. agent learning rule (optional)
% rng(0)
setnavpath

% 1. define and initialize sensory environment
env_generate_nn

%% load initial agent params
clc
nvparams10620
rsd = rand(1,4);
mpr.win = rsd/sum(rsd)*35; mpr.win(1:2) = 0;
w_in = mpr.win;
w_h = w_in
lrt = 1; % learning rate
rt_h = []; nd_h = [];
%
avr = 0;
for tri = 1:100
    fsin = []; ntr = [];rtr = [];
    for ti = 1:10
    % 2. define and initialize navigation agent
    ss_in = nan(size(w_in));
    loc0 = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
    agent_generate_lr
    
    % 3. iteratively simulate agent and environment interactions
    run_nav_update_lr

    fsin = [fsin;ss_in];
    ntr = [ntr navt];
    rtr = [rtr rwd];
    end
    
    % update input weights
    fsm = nanmean(fsin);
    ndm = nanmedian(ntr);
    learn_update_a
    
    nd_h = [nd_h;ntr];
    rt_h = [rt_h;rtr];
    w_h = [w_h;w_in];
    
%     dwh = diff(w_h,[],1);
%     ddi = max(1,(size(dwh,1)-3));
%     dwe = dwh(ddi:end,:);
end
rtm = cal_matmean(rt_h,2,1);
ndm = cal_matmean(nd_h,2,1);
figure(39);clf; hold all
yyaxis left; plot_bci([],[(rtm.mean-rtm.se);(rtm.mean+rtm.se)],rtm.mean,'b','b','')
ylabel('Average reward')
yyaxis right; plot_bci([],[(ndm.mean-ndm.se);(ndm.mean+ndm.se)],ndm.mean,'r','r','')
ylabel('Average navigation time'); xlabel('Training episode')

% yyaxis left; matsct([],rt_h,[],'b')
% yyaxis right; matsct([],nd_h,[],'r')

trstat.w_h = w_h; % weight evolution
trstat.r_h = rt_h; % reward history
trstat.nt_h = nd_h; % navigation time history
%% 5. save training data 
% reply = input('Save navmodel data? y-enter/n-any other key','s');
% if isempty(reply)
thpath = [dtpath '\trainhist\'];

    clear agt
    % compile agent data
    agt.mod = mpr;
    agt.nn_h = mout.nnh;
    agt.loc_h = loc_h;
    agt.ang_h = ang_h;
    agt.st_h = st_h;

    formatOut = 'ddhhmm';%'mmddyyhh';
    dstr = datestr(now,formatOut);
    savname = ['nav_nn_trainhist' dstr];
    if isempty(dir(savname))
        save([thpath savname],'envfile','cpm','agt','trstat')
        savfigr(plpath,savname)
    else
        save([thpath savname '_2'],'envfile','cpm','agt','trstat')
        savfig(plpath,[savname '_2'])
    end
% end

%% test learned weights
% w_in = w_h(end,:);
loc0 = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
% loc0 = [300 500];
agent_generate_lr
run_nav_update_lr
[length(st_h) sum(st_h) rwd]

ea_visualizer_2
drawnow limitrate
