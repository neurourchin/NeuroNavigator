nvparams92620
[envfile,envpath] = uigetfile([dtpath '\envs\*.mat'],'Select navigation environment');
if ~isempty(envfile)
    load([envpath envfile])
else
    env_generate
end
% global env_feat cpm rwset actnum loc0

actnum = 4; % number of movement direction allowed, assuming equal spacing 
rwset = [330 -.2]; % reward for reaching food, cost for exploring
cpm.spd = mpr.spd;
loc0 = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
%
% nav_create % uncomment global vars
navenv_create_rw

% validate the environ
validateEnvironment(env)

%% test-run the environ
rng(0);
[iniobs, logsig] = reset(env); iniobs
act0 = pi; %pi;
[nextobs,rwd,dnflg,logsig] = step(env,act0);
nextobs