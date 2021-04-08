% general framework for simulating navigation in a feature (i.e. sensory
% cue) based environment
% Components:
% 1. environment definition
% 3. environment update rule
% 2. agent definition
% 4. agent-environment update rule
% 4-2. agent learning rule (optional)
rng('shuffle') % 0
setnavpath

% 1. define and initialize sensory environment
env_generate_ar

% 2. define and initialize navigation agent
agent_generate_ar

% 3. specify training params and train agent
trainRLagent

%% 5. save navigation data if needed
% reply = input('Save navmodel data? y-any key/n-enter','s');
% if reply
    % compile agent data
% %     agt.mod = mpr;
% %     agt.nn_h = mout.nnh;
% %     agt.loc_h = loc_h;
% %     agt.ang_h = ang_h;
% %     agt.st_h = st_h;
    
    formatOut = 'mmddyyhh';
    dstr = datestr(now,formatOut);
    savname = ['navmod_ar_' dstr];
    if isempty(dir(savname))
        save([dtpath savname],'envfile','cpm','agent','trainingStats')
        savfig(plpath,[savname '.tif'])
    end
% end


% footnote: goal of this framework is to compare biological
% exploration strategy with exploration algorithms in RL. Biological
% exploration appear to be motivated by features of the sensory world, esp.
% those that have been previously associated with attaining the
% goal/similar goals. during exploration, biological agents often employ a
% run-and-tumble strategy likely to combat noisiness in the feature
% (intermittent appearance, uncertain measurement, etc.), which bears
% similarity to the way they switch between exploration and exploitation.
% Popular RL algorithms encourage exploration of uncertain states, with the
% representation of the state used as given or embeded implicitly in the function
% approximator. With these algorithms, the states that the agent chose to
% explore may be uncertain and unpromising at the same (i.e. lack of
% relevant features often can indicate low likelihood of leading to goal).

% To make the comparisons fair, artificial agents are implemented in two different
% ways: 1)they can use run-n-tumble to migrate up gradients, but
% their exploration duration will not be a function of recent sensory
% inputs, or 2) their run-n-tumble states are constant and not modulated by
% sensory input.
