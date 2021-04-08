% compute multimodal sensory cue values at every spatial coordinate

% 1. basic params
xgrid = -2000:2000; ygrid = xgrid; % just 2d for now
xsft = xgrid(1)-1; ysft = ygrid(1)-1;
xrn = diff(xgrid([1 end])); yrn = diff(ygrid([1 end]));
cmesh = meshgrid(xgrid,ygrid);
num_cue = 4; % # of cue types
num_f = 1; % # of food types

% 2. define cue and food distributions
clear f_rad f_loc
cfdist = [10 500 1500 -5]; % expected distance of cue source from center of food patch, negative indicates uniform distribution across arena
ecf = [5 15 75 -5]; % error on cfdist
np = 5; % number of food patches
f_loc{1} = [(rand(np,1)-.5)*xrn (rand(np,1)-.5)*yrn];
f_rad = 50*ones(1,num_f); % food patch radii
nsc = [np*ones(1,3) -1]; % number of cue sources, negative indicates uniform distribution
c_rad = [200*ones(1,3) inf]; % width of the cue distributions, inf indicates uniform
cpm.cfd = cfdist; cpm.cfe = ecf; cpm.np = np;
cpm.floc = f_loc; cpm.frad = f_rad;
cpm.nc = nsc; cpm.crad = c_rad;
cpm.fn = num_f; cpm.cn = num_cue;
cpm.xsft = xsft; cpm.ysft = ysft;
cpm.xrn = xrn; cpm.yrn = yrn;

% 3. generate cue distributions for entire arena
env_feat = fcdist_gen(cpm,xgrid,ygrid,pbl);

%%
if ~exist('sbflg','var')
    reply = input('Save environment? Y=enter/N=any other key: ','s');
    if isempty(reply)
        formatOut = 'ddhhmm';
        dstr = datestr(now,formatOut);
        save([dtpath 'envdata_tmp' dstr '.mat'],'env_feat','cpm')
        
        figure(229)
        savfig(plpath,['env_F' dstr])
        figure(230)
        savfig(plpath,['env_C' dstr])
    end
end