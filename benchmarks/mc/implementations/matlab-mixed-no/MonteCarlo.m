function [piValue] = MonteCarlo(inputData)
n = size(inputData, 2);
sampleOut = zeros(1,n);
%fprintf('MC1: loop(v) = %d\n',n);
%fprintf('MC2: loop(v) = %d\n',n);
% old
%for k=1:n
%    sampleOut(k) = SampleFunc(inputData(1,k),inputData(2,k));
%end
% new
k = colon(1,n);
sampleOut(k)=SampleFunc(inputData(1,k),inputData(2,k));
%
reduceCount = 0;
% old
%for k=1:n
%    reduceCount = reduceCount + sampleOut(k);
%end
%piValue = 4 * reduceCount / n;
% new
%mc_t25 = reduceCount;;
%[reduceCount] = plus(mc_t25, mc_t26);;
piValue = rdivide(times(4,plus(reduceCount,sum(sampleOut(colon(1,n))))),n);
%
end

