% find closest POI
curpt=[x y];
% if ~exist('pvec','var')
pvec=[(pdata.x)' (pdata.y)'];
% end
dist2=distcalc(pvec,curpt);
[~,deli] = min(dist2);

