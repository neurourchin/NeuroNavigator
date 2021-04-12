function bci = bootmean(bn,bdat)
ops = statset('UseParallel',true); clrs = getstateclr;
bci = bootci(bn,{@nanmean,bdat},'Options',ops);
