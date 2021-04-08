figure(134);clf;hold all
imshow(env_feat.c(1).mp,'initialmagnification','fit');colormap parula
hold all
plot(loc_h(1,1)-cpm.xsft,loc_h(1,2)-cpm.ysft,'.','color',[.87 .49 0],'markersize',25)
plot(loc_h(:,1)-cpm.xsft,loc_h(:,2)-cpm.ysft,'color',[.87 .49 0],'linewidth',2)
dti = find(st_h==0);
plot(loc_h(dti,1)-cpm.xsft,loc_h(dti,2)-cpm.ysft,'b.','markersize',12)
plot(env_feat.f(1).bds(:,1),env_feat.f(1).bds(:,2),...
    'k.','markersize',2)

plot(loc_h(end,1)-cpm.xsft+1,loc_h(end,2)-cpm.ysft+1,...
    'p','color',[.87 .49 0],'linewidth',1.5,'markersize',10)
title(num2str(w_in))
cmap = cmap_gen({[1 1 1],[0.35 .8 .35]},0);
colormap(cmap)
caxis([-1 1])
%%
ytl = [];
figure(135);clf;hold all
plot(mout.nnh); ylim([-.5 11])
plotstandard
yyaxis right;plot(ip_h,'k'); %xlim([0 300])
ylim([-9 2.25])
plotstandard
setfigsiz([886 362 409 321])

%% save plots
rply = input('Save plot> y=enter/n=other key','s');
if isempty(rply)
formatOut = 'ddhhmm';%'mmddyyhh';
dstr = datestr(now,formatOut);
savname = ['navNN_trajhst' dstr];
save([plpath savname],'envfile','cpm','agt','loc_h','st_h','ip_h','mout')
figure(134);savfigr(plpath,savname)
figure(135);savfigr(plpath,[savname '_2'])
end