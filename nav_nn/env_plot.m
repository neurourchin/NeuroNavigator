figure(230);clf;hold all
cn = cpm.cn;
for ci = 1:cn
    subplot(1,cn,ci);hold all
imshow(env_feat.c(ci).mp,'initialmagnification','fit');colormap parula
hold all
plot(env_feat.f(1).bds(:,1),env_feat.f(1).bds(:,2),...
    'k.','markersize',2)
title(['Cue #' num2str(ci)])
caxis([-1 1]); box on
end
cmap = cmap_gen({[1 1 1],[0.35 .8 .35]},0);
colormap(cmap)
setfigsiz([434 253 1034 375])