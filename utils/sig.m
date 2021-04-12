function y = sig(k,n,x)
% x can be a number or a vector
y = 1./(1+exp(-n*(x-k)));