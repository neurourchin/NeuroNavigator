setnavpath
thdir = [dtpath '\trainhist\'];
% [thfile,thpath] = uigetfile([thdir 'nav_nn_trainhist*.mat'],'Select nav_nn training history:');
% load([thpath '\' thfile]);
cfid = 41;

tflst = dir([thdir 'nav_nn_trainhist*.mat']);
rwh = [];
for fi = 1:length(tflst)
load([thdir '\' tflst(fi).name]);

w_h = trstat.w_h; % weight evolution
rt_h = trstat.r_h; % reward history
nd_h = trstat.nt_h; % navigation time history

rwh = [rwh rt_h];
end

rtm = cal_matmean(rwh,2,1);
% ndm = cal_matmean(nd_h,2,1);
figure(cfid);clf; hold all
plot_bci([],[(rtm.mean-rtm.se);(rtm.mean+rtm.se)],rtm.mean,'b','b','')
% yyaxis left; plot_bci([],rtm.ci,rtm.mean,'b','b','')

%%
td = 100;
tflst = dir([thdir 'trainnavAR_1*.mat']);
trwd = nan(length(tflst),td);

for fi = 1:length(tflst)
    thf = tflst(fi).name;
    load([thdir '\' thf]);
    trdat = trainingStats.AverageReward;
    tln = length(trdat); if tln>td; tln = td; end
    trwd(fi,1:tln) = trdat(1:tln);
end

rtm = cal_matmean(trwd,1,1);

figure(cfid);hold all
plot_bci([],[(rtm.mean-rtm.se);(rtm.mean+rtm.se)],rtm.mean,'r','r','')
% plot_bci([],rtm.ci,rtm.mean,'b','b','')
%%
tflst = dir([thdir 'trainnavAR_rw*.mat']);
trwd = nan(length(tflst),td);

for fi = 1:length(tflst)
    thf = tflst(fi).name;
    load([thdir '\' thf]);
    trdat = trainingStats.AverageReward;
    tln = length(trdat); if tln>td; tln = td; end
    trwd(fi,1:tln) = trdat(1:tln);
end

rtm = cal_matmean(trwd,1,1);

figure(cfid);hold all
plot_bci([],[(rtm.mean-rtm.se);(rtm.mean+rtm.se)],rtm.mean,[.2 .8 .4],[],'')
% plot_bci([],rtm.ci,rtm.mean,'b','b','')
ylabel('Average reward');xlabel('Training episode')

%%
rply = input('Save plot? y=enter/n=any other key','s');
if isempty(rply)
    figure(cfid)
    formatOut = 'ddhhmm';%'mmddyyhh';
    dstr = datestr(now,formatOut);
    savname = ['navCMP_trainhst' dstr];
    savfigr(plpath,savname)
end