% rlCreateEnvTemplate("nav_world")
obsInfo = getObservationInfo(env);
% % numObservations = obsInfo.Dimension(1);
actInfo = getActionInfo(env);
% % numActions = numel(actInfo);
agid = 1;

switch agid
    case 1
        DQNag_gen
    case 2
        SACag_gen
    case 3
        DDPGag_gen
    case 4
        DQNag_genc
    case 5
        DQNag_gen_gpu
end
% %
% % cip0 = zeros(obsInfo.Dimension)
% % getAction(agent,{cip0})
% % cip = rand(obsInfo.Dimension)
% % getAction(agent,{cip})