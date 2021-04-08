if length(st_h)>1
    s_input = diff(cu_buf,[],1);
else
    s_input = zeros(1,4);
end
ip_c = sum(s_input.*w_in,2)+.0;%.1

% define rules for generating motor command (agent brain)
mout = smt_fun(moin,s_input,w_in,mpr);
if st_buf(end)==1&&(length(st_buf)>mpr.erth) %erth is the max duration allowed for exploration epoch
    mout.nnh(end,:) =  [6 0];
elseif st_buf(end)==0&&(length(st_buf)>5)
    mout.nnh(end,:) =  [0 5];
end
ndr = size(mout.nnh,1)-size(moin.nnh,1);
ip_h = [ip_h;ip_c*ones(ndr,1)];
moin = mout;


% determine action state
eout = mc2act(mout,mpr);

% execute action and update location
if eout
    if st_h(end) == 0
        angc = rand*2*pi;
    else
        angc = ang_buf(end);
    end
    loc_c = loc_h(end,:) + mpr.spd*[cos(angc) sin(angc)];
else
    angc = nan;
    loc_c = loc_h(end,:);
end

% enforce boundary conditions
loc_c(1) = min(xbd(2),(max(xbd(1),loc_c(1))));
loc_c(2) = min(ybd(2),(max(ybd(1),loc_c(2))));
          

% update environ-action history and memory buffers
loc_h = [loc_h;loc_c]; % full trajectory history, not available to agent
loc_buf = [loc_buf;loc_c]; % trajectory memory buffer, accessible to agent
loc_buf = loc_buf((end-1):end,:);
ang_h = [ang_h;angc]; % full history of heading angle, not accessible to agent
ang_buf = [ang_buf;angc];
ang_buf = ang_buf((end-1):end,:);
st_h = [st_h;eout]; % full history of ee state, not accessible to agent
if eout==st_buf(end)
    st_buf = [st_buf;eout]; % not explicitly available to the agent, used to limit the duration of each state
else
    st_buf = eout;
end


