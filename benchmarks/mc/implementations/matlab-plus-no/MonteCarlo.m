function piValue = MonteCarlo(inputData)
n = size(inputData,2);
sampleOut = zeros(1,n);
k = colon(1,n);
sampleOut(k) = SampleFunc(inputData(1,k),inputData(2,k));
reduceCount = 0;
%mc_t25 = reduceCount;;
%[reduceCount] = plus(mc_t25, mc_t26);;
piValue = rdivide(times(4,plus(reduceCount,sum(sampleOut(colon(1,n))))),n);
end

function z = SampleFunc(a,b)
thenCond = lt(plus(power(a,2),power(b,2)),1);
z = plus(times(not(thenCond),0),times(thenCond,1));
end

