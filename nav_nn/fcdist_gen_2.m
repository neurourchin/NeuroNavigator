function env_feat = fcdist_gen(cpm,xgrid,ygrid,pbl)
% parse params
f_loc = cpm.floc; f_rad = cpm.frad;
nsc = cpm.nc; c_rad = cpm.crad;
cfd = cpm.cfd; cfe = cpm.cfe;
np = cpm.np;
fn = cpm.fn; cn = cpm.cn;

[mx,my] = meshgrid(xgrid,ygrid);
csiz = size(mx);
env_feat.crdx = mx; 
env_feat.crdy = my; 

% compute food distribution
if pbl
figure(229);clf; hold all
title('Food patch map')
end
theta = (0:2:360)*2*pi/360;
for ti = 1:fn
    cfr = f_rad(ti);
    fmsk = zeros([csiz,np]);
    flc = f_loc{ti};
    fbds = [];
    for fi = 1:np
        cfc = flc(fi,:);
        cfx = cfc(1)+cfr*cos(theta)-xgrid(1);
        cfy = cfc(2)+cfr*sin(theta)-ygrid(1);
        fbds = [fbds;[cfx(:),cfy(:)]];
        fmsk(:,:,fi) = poly2mask(cfx,cfy,csiz(1),csiz(2));
    end
    env_feat.f(ti).mp = sum(fmsk,3);
    env_feat.f(ti).bds = fbds;
    env_feat.flc{ti} = flc;
    if pbl
    subplot(1,fn,ti); imshow(env_feat.f(ti).mp)
    end
end



% compute cue distribution
theta = 0:360;
for ti = 1:cn
        cfr = c_rad(ti);
        nc = nsc(ti);
        cloc = nan(nc,2);
        cdst = zeros([csiz,nc]);
        ccfd = cfd(ti);
        ccfe = cfe(ti);
    for fi = 1:nc
        if ccfd>=0&&ccfd<=1500&&fi<=np
            cfa = rand*2*pi;
            cfc = sum([flc(fi,:);ccfd*(max(0,...
                (1+normrnd(0,.05))))*[cos(cfa) sin(cfa)]],1);
            cfc(:,1) = max(xgrid(1)+200,cfc(:,1));
            cfc(:,2) = max(ygrid(1)+200,cfc(:,2));
            cfc(:,1) = min(xgrid(end)-200,cfc(:,1));
            cfc(:,2) = min(ygrid(end)-200,cfc(:,2));
        else
            cfc = [(rand-.5)*xgrid(end) (rand-.5)*ygrid(end)];
        end
        mdst = sqrt(((mx-cfc(1)).^2)+((my-cfc(2)).^2));% compute distance of all grid points to cue source
        cdst(:,:,fi) = exp(-mdst/cfr);
        cloc(fi,:) = cfc;
    end
    env_feat.c(ti).mp = sum(cdst,3);
    env_feat.clc{ti} = cloc;
end
env_plot