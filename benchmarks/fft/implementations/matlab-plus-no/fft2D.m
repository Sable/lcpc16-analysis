function [rtnR,rtnI] = fft2D(xR,xI,N)
% rtn -> return value;
rtnR = zeros(N, N);
rtnI = zeros(N, N);
mc_t98 = 1;
for i = (mc_t98 : N);
[resR, resI] = fftSimple(xR(i, :),xI(i, :),N);
k = colon(1,N);
rtnI(i, k) = resI(k);
rtnR(i, k) = resR(k);
end
rtnR = transpose(rtnR);
rtnI = transpose(rtnI);
mc_t100 = 1;
for i = (mc_t100 : N);
[resR, resI] = fftSimple(rtnR(i, :),rtnI(i, :),N);
k = colon(1,N);
rtnI(i, k) = resI(k);
rtnR(i, k) = resR(k);
end
rtnR = transpose(rtnR);
rtnI = transpose(rtnI);
end

function [rtnR,rtnI] = fftSimple(xR,xI,N)
rtnR = zeros(1,N);
rtnI = zeros(1,N);
mc_t172 = eq(N,1);
if mc_t172
mc_t153 = 1;
rtnR(mc_t153) = xR(1);
mc_t155 = 1;
rtnI(mc_t155) = xI(1);
else
half = floor(rdivide(N,2));
eR = zeros(1,half);
eI = zeros(1,half);
dR = zeros(1,half);
dI = zeros(1,half);
mc_t167 = 1;
for k = (mc_t167 : half);
eR(k) = xR(minus(times(2,k),1));
eI(k) = xI(minus(times(2,k),1));
dR(k) = xR(times(2,k));
dI(k) = xI(times(2,k));
end
[VecER, VecEI] = fftSimple(eR, eI, half);
[VecDR, VecDI] = fftSimple(dR, dI, half);
mc_t170 = 1;
for k = (mc_t170 : half);
r = 1;
rad = rdivide(times(times(uminus(2.0),pi()),minus(k,1)),N);
cR = times(r,cos(rad));
cI = times(r,sin(rad));
VecDR(k) = minus(times(VecDR(k),cR),times(VecDI(k),cI));
VecDI(k) = plus(times(VecDR(k),cI),times(VecDI(k),cR));
end
mc_t171 = 1;
for k = (mc_t171 : half);
rtnR(k) = plus(VecER(k),VecDR(k));
rtnI(k) = plus(VecEI(k),VecDI(k));
mc_t111 = plus(k, half);
rtnR(mc_t111) = minus(VecER(k),VecDR(k));
mc_t112 = plus(k, half);
rtnI(mc_t112) = minus(VecEI(k),VecDI(k));
end
end
end

