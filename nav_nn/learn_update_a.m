[~,wsr] = sort(w_in,'ascend');
if ndm>1200
    w_in(wsr(end)) = w_in(wsr(end))-5*lrt;
    w_in(wsr(1:3)) = w_in(wsr(1:3))+rand(1,3)*5;
    succ = 0;
end

if sum(~isnan(fsm))
    if nnz(fsm)
        smf = fsm/nanmean(fsm);
        %     w_in(wxi) = w_in(wxi)*(1+lrt);
        %     w_in = w_in/sum(w_in);
        w_in = w_in.*smf;
        w_in = max(0,w_in);
        w_in = (w_in/nanmax(w_in))*35;
        if sum(isnan(w_in))
            ohno
        end
        succ = 1;
    end
end

disp(['Success: ' num2str(succ) ...
    ':  Updated input weights to ' sprintf('%0.2f %0.2f %0.2f %0.2f',w_in)])

% formatSpec = 'The array is %dx%d.';
% A1 = 2;
% A2 = 3;
% str = sprintf(formatSpec,A1,A2)