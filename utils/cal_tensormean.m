function dout = cal_tensormean(din,rfdim,lpdim,mndim)
lpn = size(din,lpdim);
mnm = size(din,mndim);
dnm = size(din,rfdim);

for li = 1:lpn
    for di = 1:dnm
        dvals = squeeze(din(di,li,:)); dvals(isnan(dvals)) = [];
        da(di,li) = mean(dvals);
        dci(di,li,:) = bootci(50,@mean,dvals);
    end
end

dout.mean = da;
dout.ci = dci;