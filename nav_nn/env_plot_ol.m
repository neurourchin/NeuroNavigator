
cn = cpm.cn;
rgbi = [];
coi = [1 3];
msiz = size(env_feat.c(1).mp);
% rgbi = zeros(msiz(1),msiz(2),3);
mpi = zeros(msiz(1),msiz(2));

cii = 1;
for ci = coi
    cth = .08;
    cmdt = env_feat.c(ci).mp;
    cmdt(cmdt<=cth) = 0;
   mpi = mpi+1.3*(cii-1)*(cmdt>cth)+cmdt;
    cii = cii+1;
end
cmap = cmap_gen({[1 1 1],[.8 .2 .2],[1 1 1] [0.35 .2 .85]},1);

figure(233);clf;hold all
imshow(mpi,'initialmagnification','fit');
hold all
colormap(cmap)
caxis([0 (cii)*.75])
% setfigsiz([434 253 1034 375])