% Initialize observation settings
obsInfo = rlNumericSpec([1 4]);
obsInfo.Name = 'diffusive cues';
obsInfo.Description = 'cue1, cue2, cue3, cue4';

% Initialize action settings
% discretize movement direction 
dstp = 2*pi/actnum;
actInfo = rlFiniteSetSpec(0:dstp:((2*pi)-dstp));
actInfo.Name = 'discretized movement angle (radian)';

% reset_handle = @(iniobs, logsig) nav_reset(loc0,env_feat,cpm);
reset_handle = @nav_reset;
step_handle = @(act,logsig) nav_step(act,logsig);

env = rlFunctionEnv(obsInfo,actInfo,step_handle,reset_handle);

