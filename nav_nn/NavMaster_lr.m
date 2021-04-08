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
global env_feat cpm mpr

% 1. define and initialize sensory environment
env_generate_nn

%% load initial agent params
nvparams10620
mpr.win = [0 1 0 0]*35;
w_in = mpr.win;
% lrt = 1; % learning rate

w0 = [0 0 .8 .5]*35;
opts = optimset('Display','iter','PlotFcns','optimplotfval','TolX',1e-3); % 1e-7
wopt = fminsearch(@nav_lr_routine,w0,opts)

%% test learned weights
w_in = wopt;
w_in = [1 0 0 0]*35;
% loc0 = [(rand-.5)*xrn (rand-.5)*yrn];
loc0 = [300 500];
agent_generate_lr
run_nav_update_lr
rwd

ea_visualizer
drawnow limitrate
%% 5. save navigation data if needed
% compile agent data
clear agt
agt.mod = mpr;
agt.nn_h = mout.nnh;
agt.loc_h = loc_h;
agt.ang_h = ang_h;
agt.st_h = st_h;
agt.w_in = w_in;

reply = input('Save navmodel data?','s');
if ~isempty(reply)
    formatOut = 'ddhhmm';%'mmddyyhh';
    dstr = datestr(now,formatOut);
    savname = ['navmod' dstr];
    if isempty(dir(savname))
        save([dtpath savname],'envfile','cpm','agt')
        savfigr(plpath,savname)
    else
        save([dtpath savname '_2'],'envfile','cpm','agt')
        savfig(plpath,[savname '_2'])
    end
end



