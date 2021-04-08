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
    'ScoreAveragingWindowLength',15,...
    'SaveAgentCriteria','AverageReward',...
    'SaveAgentValue',100,...
    'Plots','none',... % 'training-progress'
     'SaveAgentDirectory',tadir,...
    'StopTrainingCriteria','AverageReward',... % 'EpisodeCount'
    'StopTrainingValue',100);
%    


% plot(env)

% Train the agent.
trainingStats = train(agent,env,trainOpts);
ilc = env.iniloc;
env_visualizer
%%

assess_trained_ar_rw
%%
tflg = 1;
if tflg
for ti = 1:50
    % % for ti = 1:600
    % env.iniloc = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
    % env.iniloc = env.iniloc+rand(1,2)*3;
    env.iniloc = ilc;
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
end
% % %%
% % envlab = envfile(12:(end-4));
% % svlab = input('Save plot as: ','s');
% % if ~isempty(svlab)
% %     svname = ['navex' envlab '_ex' svlab];
% %     savfigr(plpath,svname)
% % end