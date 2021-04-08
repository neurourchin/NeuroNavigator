% scan for param sets that give suitable switching behavior for ctx
idn = 350; XS0=[0 1.1];
xr1 = [-1 8]; xr2 = xr1; inc = [.2 .2];
fid = 0; dq = 0;

prm.tau = [1 1];
prm.b = 4.5*[1 1];
prm.k = -.5*[1 1]; %prm.n(4)=2;
prm.n = 5*[1 1];%[1.6 2];
prm.bs = [2 0];
ilst = 0:4;%0:.2:3;
il = (length(ilst));
rl = ceil(length(ilst)/2);

fiid = 20;
figure(fiid);clf;hold all

for ii = 1:length(ilst)
    subplot(2,il,ii); hold all;
    ninp = ilst(ii);
    prm.ic = 2;%.5*ninp;
    title(['Input ' num2str(ninp) ' AIA ' num2str(prm.ic)])
    [nco,uo] = nullcfun_nv(xr1,xr2,inc,ninp,prm,fid,dq);
    caxis([0 5])
    if ii>1
        plot(nco.x,pry,'k:','linewidth',1.5);
        plot(prx,nco.y,'r:','linewidth',1.5)
    end
    if ii==1
        prx = nco.nx; pry = nco.ny;
    end
    
end

cmap = cmap_gen({[0 0 .8],[0.7 .9 1]},0);
% cmap = cmap(end:-1:1,:);
colormap(cmap)
%% simulate dynamics for a particular set of params
xt0 = [0 5];
tdr = 300;
ninp = .1;
prm = mpr;
prm.nsf = .5;

xto = runeemod(xt0,prm,ninp,tdr);

figure(fiid+1);clf;hold all
subplot 121; hold all
[nco,uo] = nullcfun_nv(xr1,xr2,inc,ninp,prm,fid,dq);
caxis([0 5])
plot(xto(:,1),xto(:,2),'w','linewidth',1.5)
subplot 122; hold all
plot(xto)
%%
% setsavpath
% svpath = [dbpath '\ImageSeg_GUI\MNI segmentation\MNI turbotrack (dropbox)\Figures\Model\Plots\'];
% svname = 'mod_prmsc_iacp';
% svfig(fiid,svname,svpath)

