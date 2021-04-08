rng('shuffle')
formatOut = 'ddhhmm';
dtstr = datestr(now,formatOut);
tadir = [dtpath 'savedAgent' dtstr];
if ~exist('tadir','dir')
    mkdir(tadir)
end
trainOpts = rlTrainingOptions(...
    'MaxEpisodes',1200,...
    'MaxStepsPerEpisode',1500,...
    'Verbose',true,...
    'UseParallel',false,...
    'ScoreAveragingWindowLength',25,...
    'SaveAgentCriteria','AverageReward',...
    'SaveAgentValue',150,...
    'Plots','none',... % 'training-progress'
    'SaveAgentDirectory',tadir,...
    'StopTrainingCriteria','EpisodeCount',... %'EpisodeCount',... % 'AverageReward'
    'StopTrainingValue',150);% 220


% plot(env)
env.iniloc = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
% env.iniloc = [1880 1008];
% Train the agent.
trainingStats = train(agent,env,trainOpts);
ilc = env.iniloc;
env_visualizer

formatOut = 'ddhhmm';
dstr = datestr(now,formatOut);

envlab = envfile(12:(end-4));
    svname = ['navARe' envlab '_trnd_' dstr];
    savfigr(plpath,svname)
%%
% reply = input('proceed to perf testing? y=enter/n=any other key ','s');
% if isempty(reply)
pflg = 0;
if pflg
assess_trained_ar
end
%%
tflg = 0;
if tflg
    %%
    for ti = 1:1
        % % for ti = 1:600
        % env.iniloc = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
        % env.iniloc = env.iniloc+rand(1,2)*3;
        simOptions = rlSimulationOptions('MaxSteps',1500);
        experience = sim(env,agent,simOptions);
        rwd = sum(experience.Reward.Data);
        nt = length(env.Logsig.act_h);
        [rwd nt]
        env_visualizer
        pause(.1)
        % %     if rwd>30&&nt>20
        % %         envlab = envfile(12:(end-4));
        % %         svlab = input('Save plot as: ','s');
        % %         if ~isempty(svlab)
        % %             svname = ['navex' envlab '_ex' svlab];
        % %             savfigr(plpath,svname)
        % %         end
        % %     end
        % % end
    end
% % formatOut = 'ddhhmm';
% % dstr = datestr(now,formatOut);
% % 
% % envlab = envfile(12:(end-4));
% % svlab = input('Save plot as: ','s');
% % if ~isempty(svlab)
% %     svname = ['navARe' envlab '_ex' svlab '_' dstr];
% %     savfigr(plpath,svname)
% % end
end