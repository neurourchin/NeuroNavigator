cn = cpm.cn;
imshow(env_feat.c(1).mp,'initialmagnification','fit');colormap parula
hold all
plot(env_feat.f(1).bds(:,1),env_feat.f(1).bds(:,2),...
    'k.','markersize',2)
caxis([-1 1]); box on
cmap = cmap_gen({[1 1 1],[0.35 .8 .35]},0);
colormap(cmap)
% setfigsiz([434 253 1034 375])