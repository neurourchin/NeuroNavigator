function dout = cal_matmedian_ds(mat,dim,dw,dbt)
%%
ops = statset('UseParallel',true);
bn = 100;
if isempty(dim)
    dim = 1;
end
if dim == 2
    mat = mat';
end
rn = size(mat,1);
cn = size(mat,2);
dn = ceil(size(mat,2)/dw);

if ~isempty(mat)
    parfor di = 1:dn
        dr = min(cn,(1:dw)+(di-1)*dw);
        dvals = mat(:,dr); dvals(isnan(dvals)) = [];
        da(di) = nanmedian(dvals(:));
        de(di) = std(dvals(:))/sqrt(numel(dvals));
        if dbt
            
            if length(dvals)>1
                dci(:,di) = bootci(bn,{@nanmedian,dvals(:)});%,'Options',ops);
            else
                dci(:,di) = [nan;nan];
            end
        end
    end
    
    dout.mean = da;
    dout.se = de;
    if dbt
        dout.ci = dci;
    else
        dout.ci = [];
    end
else
    dout.mean = [];
    dout.se = [];
    dout.ci = [];
end
