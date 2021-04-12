function dout = cal_matmean(mat,dim,dbt)
%%
bn = 100;
rn = size(mat,1);
cn = size(mat,2);

if isempty(dim)
    dim = 1;
end
% ops = statset('UseParallel',true);

if ~isempty(mat)
    switch dim
        case 1
            for di = 1:cn
                dvals = mat(:,di); dvals(isnan(dvals)) = [];
                da(di) = nanmedian(dvals);
                de(di) = std(dvals)/sqrt(length(dvals));
                if dbt
                    
                    if length(dvals)>1
                        dci(:,di) = bootci(bn,{@nanmedian,dvals}); %,'Options',ops
                    else
                        dci(:,di) = [nan;nan];
                    end
                end
            end
        case 2
            for di = 1:rn
                dvals = mat(di,:); dvals(isnan(dvals)) = [];
                da(di) = nanmedian(dvals);
                de(di) = std(dvals)/sqrt(length(dvals));
                if dbt
                    if length(dvals)>1
                        dci(:,di) = bootci(bn,@nanmedian,dvals);
                    else
                        dci(:,di) = [nan;nan];
                    end
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
