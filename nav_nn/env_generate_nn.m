if ~exist('pbl','var')
    pbl = 1;
end
[envfile,envpath] = uigetfile([dtpath 'envs\*.mat'],'Select navigation environment');
if ~isempty(envfile)
    load([envpath envfile])
else
    env_generate
end