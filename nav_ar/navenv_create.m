%% load navigation environment template
%% load and specify params
% % nvparams92620
% % [envfile,envpath] = uigetfile([dtpath '*.mat'],'Select navigation environment');
% % if ~isempty(envfile)
% %     load([envpath envfile])
% % else
% %     env_generate
% % end

% % actnum = 4; % number of movement direction allowed, assuming equal spacing 
% % rwset = [100 -.2]; % reward for reaching food, cost for exploring
% % cpm.spd = mpr.spd;
% % loc0 = [1729 3500]+cpm.xsft;%[(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];

%%
env = nav_env
%%
env.env_feat = env_feat;
env.env_param = cpm;
% env.iniloc = loc0;
env.actnum = actnum;
% rwds.cost = -.2; rwds.r = 100;
env.rwds.r = rwset(1);
env.rwds.cost = rwset(2);