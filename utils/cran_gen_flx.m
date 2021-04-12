function crange=cran_gen_flx(color1,color2,cl1,cl2)
if isempty(cl1); cl1 = 200; end
if isempty(cl2); cl2 = cl1; end

crange=zeros(cl1+cl2+1,3);
% first 200 rows gradient of color1
inc1=(1-color1(1))/cl1;
if inc1==0;crange(1:(cl1+1),1)=ones((cl1+1),1);else crange(1:(cl1+1),1)=(color1(1):inc1:1)';end
inc2=(1-color1(2))/cl1;
if inc2==0;crange(1:(cl1+1),2)=ones((cl1+1),1);else crange(1:(cl1+1),2)=(color1(2):inc2:1)';end
inc3=(1-color1(3))/cl1;
if inc3==0;crange(1:(cl1+1),3)=ones((cl1+1),1);else crange(1:(cl1+1),3)=(color1(3):inc3:1)';end

% second 200 rows gradient of color2
inc1=(1-color2(1))/cl2;
if inc1==0;crange(cl1+(1:(cl2+1)),1)=ones((cl2+1),1);else crange(cl1+(1:(cl2+1)),1)=(1:-inc1:color2(1))';end
inc2=(1-color2(2))/cl2;
if inc2==0;crange(cl1+(1:(cl2+1)),2)=ones((cl2+1),1);else crange(cl1+(1:(cl2+1)),2)=(1:-inc2:color2(2))';end
inc3=(1-color2(3))/cl2;
if inc3==0;crange(cl1+(1:(cl2+1)),3)=ones((cl2+1),1);else crange(cl1+(1:(cl2+1)),3)=(1:-inc3:color2(3))';end