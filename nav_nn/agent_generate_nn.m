% define agent capable of klinokinesis, klinotaxis and switching
% between exploration and exploitation states dep or indep of sensory inputs
% load agent params
nvparams10620
% % % xrn = diff(env_feat.crdx([1 end]));
% % % yrn = diff(env_feat.crdy([1 end]));
% % % define sensor inputs
% % s_input = diff(cu_buf,[],1);
% %
% % % define rules for generating motor command (agent brain)
% % mout = smt_fun(s_input,cpm);
% %
% % % determine and execute motor actions
% % dloc = mc2loc(mout);
global loc_h loc_buf ang_h ang_buf st_h st_buf cu_h cu_buf
global ip_h
% initialize agent
loc0 = [(rand-.5)*cpm.xrn (rand-.5)*cpm.yrn];
loc_h = loc0; loc_buf = loc0; loc_c = loc_buf(end,:);
ang_h = rand*2*pi; ang_buf = ang_h(end);
st_h = 1; st_buf = 1; %explore = 1, exploit = 0
cu_h = []; cu_buf = [];
ip_h = 0;

% initialize environment state as experienced by agent
cc_st = nan(1,cpm.cn); % current cue values, i.e. representation for the state of the environment
for ti = 1:cpm.cn
    cc_st(ti) = env_feat.c(ti).mp(round(loc_c(2)-cpm.ysft),...
        round(loc_c(1)-cpm.xsft)); % query cue values from predetermined maps
end
cu_h = [cu_h;cc_st]; % store env states into state history, not available ot agent
cu_buf = [cu_buf;cc_st]; % recent environ state buffer, available to agent

moin.nnh = [0 6];
w_in = mpr.win;
s_in = [0 0 0 0];
% calibration tests