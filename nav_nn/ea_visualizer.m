figure(133);clf;hold all
subplot(2,3,[1:2 4:5]);hold all
imshow(env_feat.c(1).mp);colormap parula
% plot(env_feat.f(1).bds(:,1),env_feat.f(1).bds(:,2),...
%     'm','linewidth',1.5)
plot(loc_h(1,1)-cpm.xsft,loc_h(1,2)-cpm.ysft,'ro','linewidth',1.5)
plot(loc_h(:,1)-cpm.xsft,loc_h(:,2)-cpm.ysft,'color',.85*ones(1,3))
hl = size(loc_h,1); tp1 = max(1,(hl-10));
plot(loc_h(tp1:end,1)-cpm.xsft+1,loc_h(tp1:end,2)-cpm.ysft+1,...
    'r','linewidth',2.5)
title(num2str(w_in))

subplot(2,3,3); hold all
ml = size(mout.nnh,1); tm1 = max(1,(ml-250));
plot(mout.nnh(tm1:end,:)); 
xlim([0 300])

subplot(2,3,6); hold all
yyaxis left;plot(ip_h(tm1:end))
xlim([0 300])
yyaxis right;plot(st_h(tp1:end))
xlim([0 300/5])