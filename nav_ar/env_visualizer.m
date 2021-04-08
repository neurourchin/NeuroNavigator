figure(260);clf;hold all
% % plot navigation environment
% imshow(env_feat.c(1).mp);colormap parula
% hold all
% plot(env_feat.f(1).bds(:,1),env_feat.f(1).bds(:,2),...
%     'm.','linewidth',1.5)
env_plotmod


% Query agent trajecotry
locxy = env.Logsig.loc_h;

% Initialize the trajectory plot
trjplot = plot(locxy(:,1)-cpm.xsft,locxy(:,2)-cpm.ysft,'k','linewidth',1.5);
strtplot = plot(locxy(1,1)-cpm.xsft,locxy(1,2)-cpm.ysft,'go','linewidth',1.5,'markerfacecolor','g');
endplot = plot(locxy(end,1)-cpm.xsft,locxy(end,2)-cpm.ysft,'ro','linewidth',1.5,'markerfacecolor','r');