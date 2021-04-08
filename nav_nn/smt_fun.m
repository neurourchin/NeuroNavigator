function mo = smt_fun(moin,s_in,w_in,mpr)
% we, organized by rows, describes how inputs are combined as a weighted sum and incorporated
% into controller for each behavior state
% mpr is a structure that encompasses params internal to the agent
nnh = moin.nnh;
nrT = 5; % how many steps to run the brain circuit before executing the next movement
% determines speed of brain circuit relative to motor excusion
nsf = mpr.nsf; % .5

% brain circuit for explore-exploit
nst0 = nnh(end,:); nsp = nst0;
nts = [];
ninp = sum(s_in.*w_in,2);
for xt = 1:nrT
    no = eefun(nsp(1),nsp(2),ninp,mpr);
    dna = [no.dx1 no.dx2]+nsf*[normrnd(0,1,1,2)];
    nnact = max(0,(nsp+dna*mpr.dt));
    nts = [nts;nnact];
    nsp = nnact;
end
nnh = [nnh;nts];

mo.nnh = nnh;

% during exploration, agent will initiate locomotion at random direction,
% keep going with slow directional drift
