% generate agent using custom DNN critic representation
dnn = [
    featureInputLayer(obsInfo.Dimension(2),'Normalization','none','Name','state')
    fullyConnectedLayer(24,'Name','CriticStateFC1')
    reluLayer('Name','CriticRelu1')
    fullyConnectedLayer(24, 'Name','CriticStateFC2')
    reluLayer('Name','CriticCommonRelu')
    fullyConnectedLayer(length(actInfo.Elements),'Name','output')];

% figure
% plot(layerGraph(dnn))

agentOpts = rlDQNAgentOptions(...
    'UseDoubleDQN',false,...    
    'TargetUpdateMethod',"smoothing",...
    'TargetSmoothFactor',1e-3,... 
    'ExperienceBufferLength',1e6,... 
    'DiscountFactor',0.99,...
    'MiniBatchSize',48); % 64

criticOpts = rlRepresentationOptions('LearnRate',0.001,'GradientThreshold',1); % ,'UseDevice',"gpu"
critic = rlQValueRepresentation(dnn,obsInfo,actInfo,'Observation',{'state'},criticOpts);

agent = rlDQNAgent(critic,agentOpts);

getAction(agent,rand(obsInfo(1).Dimension))
