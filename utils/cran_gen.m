function crange=cran_gen(color1,color2)
crange=zeros(401,3);
% first 200 rows gradient of color1
inc1=(1-color1(1))/200;
if inc1==0;crange(1:201,1)=ones(201,1);else crange(1:201,1)=(color1(1):inc1:1)';end
inc2=(1-color1(2))/200;
if inc2==0;crange(1:201,2)=ones(201,1);else crange(1:201,2)=(color1(2):inc2:1)';end
inc3=(1-color1(3))/200;
if inc3==0;crange(1:201,3)=ones(201,1);else crange(1:201,3)=(color1(3):inc3:1)';end

% second 200 rows gradient of color2
inc1=(1-color2(1))/200;
if inc1==0;crange(201:401,1)=ones(201,1);else crange(201:401,1)=(1:-inc1:color2(1))';end
inc2=(1-color2(2))/200;
if inc2==0;crange(201:401,2)=ones(201,1);else crange(201:401,2)=(1:-inc2:color2(2))';end
inc3=(1-color2(3))/200;
if inc3==0;crange(201:401,3)=ones(201,1);else crange(201:401,3)=(1:-inc3:color2(3))';end