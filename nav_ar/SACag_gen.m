initOpts = rlAgentInitializationOptions('NumHiddenUnit',128);
agentOpts = rlDQNAgentOptions(...
    'UseDoubleDQN',false,...    
    'TargetUpdateMethod',"smoothing",...
    'TargetSmoothFactor',1e-3,... 
    'ExperienceBufferLength',1e6,... 
    'DiscountFactor',0.99,...
    'MiniBatchSize',48);

agent = rlSACAgent(obsInfo,actInfo,initOpts);

% check agent
getAction(agent,rand(obsInfo(1).Dimension))
