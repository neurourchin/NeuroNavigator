% generate agent using largely default critic representation
initOpts = rlAgentInitializationOptions('NumHiddenUnit',128);
agentOpts = rlDQNAgentOptions(...
    'UseDoubleDQN',false,...    
    'TargetUpdateMethod',"smoothing",...
    'TargetSmoothFactor',1e-3,... 
    'ExperienceBufferLength',1e6,... 
    'DiscountFactor',0.99,...
    'MiniBatchSize',48); % 64

agent = rlDQNAgent(obsInfo,actInfo,initOpts);
% agent.EpsilonGreedyExploration.EpsilonDecay = 1e-5;

% modify critic specs
% % critic = getCritic(agent);
% % critic.Options.LearnRate = 1e-3;
% % agent  = setCritic(agent,critic);

% check agent
getAction(agent,rand(obsInfo(1).Dimension))
