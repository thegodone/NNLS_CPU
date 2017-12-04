function randomNNLS

m = 512; %Number of equations
n = 512; %Number of unknowns
nSys = 3;

rand('state', 2011)

%A = rand(m, n, nSys);

A = zeros(m, n, nSys);
b = rand(m, nSys);

%Gaussian time series
for s = 1:nSys
   for i = 1:m
      for j = 1:n
         sigma = m/100.0; 
         A(i, j, s) = exp(-(i-j)*(i-j)/(2*(sigma*sigma)));
      end
   end
end

%Generic matlab lsqnoneg
disp('now lsqnoneg:')
tic
for s=1:nSys
   [x1, resnorm, residual, exitflag, output] = lsqnonneg(A(:,:,s), b(:,s));
   output
end
toc
disp('=================\n\n\n')

%MKL/OMP with update/downdate mex NNLS
disp('now MKL/OMP:')
tic
x2 = NNLS(1, A, b, nSys, 0, m, n, 1e-8, 4, 1);
%x2 = NNLS(0, single(A), single(b), nSys, 0, m, n, 1e-6, 8, 1);
toc

%Check norm of last system
%norm(x1-x2((1+n*(nSys-1)):end)')


