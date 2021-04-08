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
nvparams10620
mpr.win = [0 1 0 0]*35;
w_in = mpr.win;
lrt = 1; % learning rate

avr = 0;
while avr < 20
    % 2. define and initialize navigation agent
    agent_generate_lr
    
    % 3. iteratively simulate agent and environment interactions
    run_nav_update_lr
    
    % update input weights
    learn_update
end
%% 5. save navigation data if needed
reply = input('Save navmodel data?','s');
if ~isempty(reply)
    clear agt
    % compile agent data
    agt.mod = mpr;
    agt.nn_h = mout.nnh;
    agt.loc_h = loc_h;
    agt.ang_h = ang_h;
    agt.st_h = st_h;
    
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



