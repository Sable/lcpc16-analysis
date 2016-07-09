function lgdr(x,n)
PNa = PN_Legendre_vectN(x, n);
PNxa = PNx_Legendre_vectN(x, n);
PNxxa = PNxx_Legendre_vectN(x, n);
end

function PNa = PN_Legendre_vectN(x,n)
% This evaluates the NORMALIZED, ORTHOGONORMAL Legendre polynomials;
% P_{n)(x) for all degrees up to and including n. x may be either;
% a scalar or a vector.;
% Input:  x = scalar or vector of grid points where Legendre polynomials;
%             are to be evaluated.;
%         n = degree of highest Legendre polynomial needed.;
% Output: PNa is a size(x) times (n+1) array;
% Example:;
%  let x = [0 0.3 0.9], n=3. Then the output will be the 3x4 array;
%  PNa = | P_0(x(1)=0)   P_{1}(x(1))  P_{2}(x(1))  P_{3}(x(1)) |;
%        | P_0(x(2)=0.3) P_{1}(x(2))  P_{2}(x(2))  P_{3}(x(2)) |;
%        | P_0(x(3)=0.9) P_{1}(x(3))  P_{2}(x(3))  P_{3}(x(3)) |;
PNa = zeros(length(x),plus(n,1));
mc_t194 = 1;
PNa(:, mc_t194) = 1;
mc_t196 = gt(n,0);
if mc_t196
mc_t195 = 2;
PNa(:, mc_t195) = transpose(x);
else
end
% if;
mc_t206 = gt(n,1);
if mc_t206
mc_t185 = minus(n,1);
mc_t205 = 1;
for j = (mc_t205 : mc_t185);
mc_t169 = plus(j,2);
PNa(:, mc_t169) = times(rdivide(1,plus(j,1)),minus(times(times(plus(times(2,j),1),transpose(x)),PNa(:,plus(j,1))),times(j,PNa(:, j))));
end
% j;
else
end
% if;
mc_t191 = plus(n,1);
mc_t211 = 1;
for j = (mc_t211 : mc_t191);
PNa(:, j) = times(PNa(:, j),sqrt(minus(j,rdivide(1,2))));
end
% j;
end

function PNxxa = PNxx_Legendre_vectN(x,n)
% This evaluates the  SECOND DERIVATIVE of the NORMALIZED, ORTHOGONORMAL;
% Legendre polynomials P_{n)(x) for all degrees up to and including N.;
% x may be either a scalar or a vector;
% Input:  x = scalar or vector of grid points where Legendre polynomials;
%             are to be evaluated.;
%         n = degree of highest Legendre polynomial needed.;
% Output: PNxxa is a  size(x) times (n+1) array;
% Example:;
%  let x = [0.1 0.3 ], n=3. Then the output will be the 2 x 4 array;
%  PNxxa= | P_{0,xx}(x(1)=0.1) P_{1,xx}(x(1)) P_{2,xx}(x(1)) P_{3,xx}(x(1))|;
%         | P_{0,xx}(x(2)=0.3) P_{1,xx}(x(2)) P_{2,xx}(x(2)) P_{3,xx}(x(2))|;
%  P"_{n+3} = (1/(n+1))*{2(n+5/2)*x*P"_{n+2}-(n+4) P"_{n+1}};
PNxxa = zeros(length(x),plus(n,1));
mc_t302 = 1;
PNxxa(:, mc_t302) = 0;
mc_t305 = gt(n,0);
if mc_t305
mc_t304 = 2;
PNxxa(:, mc_t304) = 0;
else
end
% if;
mc_t309 = gt(n,1);
if mc_t309
mc_t308 = 3;
PNxxa(:, mc_t308) = 3;
else
end
% if;
mc_t313 = gt(n,2);
if mc_t313
mc_t312 = 4;
PNxxa(:, mc_t312) = times(15,transpose(x));
else
end
% if;
mc_t326 = gt(n,3);
if mc_t326
mc_t293 = minus(n,3);
mc_t325 = 1;
for j = (mc_t325 : mc_t293);
mc_t273 = plus(j,4);
PNxxa(:, mc_t273) = times(rdivide(1,plus(j,1)),minus(times(times(times(2,plus(j,rdivide(5,2))),transpose(x)),PNxxa(:,plus(j,3))),times(plus(j,4),PNxxa(:,plus(j,2)))));
end
% j;
else
end
% if;
mc_t299 = plus(n,1);
mc_t331 = 1;
for j = (mc_t331 : mc_t299);
PNxxa(:, j) = times(PNxxa(:, j),sqrt(minus(j,rdivide(1,2))));
end
% j;
end

function PNxa = PNx_Legendre_vectN(x,n)
% This evaluates the FIRST DERIVATIVE of the NORMALIZED, ORTHOGONORMAL;
% Legendre polynomials P_{n)(x) for all degrees up to and including N.;
% x may be either a scalar or a vector.;
% Input:  x = scalar or vector of grid points where Legendre polynomials;
%             are to be evaluated.;
%         n = degree of highest Legendre polynomial needed.;
% Output: PNxa is a  size(x) times (n+1) array;
% Example:;
%  let x = [0 0.3 0.9], n=3. Then the output will be the 3x4 array;
%  PNxa = |dP_0/dx(x(1)=0)   dP_{1}/dx(x(1)) dP_{2}/dx(x(1)) dP_{3}/dx(x(1))|;
%         |dP_0/dx(x(2)=0.3) dP_{1}/dx(x(2)) dP_{2}/dx(x(2)) dP_{3}/dx(x(2))|;
%         |dP_0/dx(x(3)=0.9) dP_{1}/dx(x(3)) dP_{2}/dx(x(3)) dP_{3}/dx(x(3))|;
PNxa = zeros(length(x),plus(n,1));
mc_t244 = 1;
PNxa(:, mc_t244) = 0;
mc_t247 = gt(n,0);
if mc_t247
mc_t246 = 2;
PNxa(:, mc_t246) = 1;
else
end
% if;
mc_t251 = gt(n,1);
if mc_t251
mc_t250 = 3;
PNxa(:, mc_t250) = times(3,transpose(x));
else
end
% if;
mc_t264 = gt(n,2);
if mc_t264
mc_t235 = minus(n,2);
mc_t263 = 1;
for j = (mc_t263 : mc_t235);
mc_t215 = plus(j,3);
PNxa(:, mc_t215) = times(rdivide(1,plus(j,1)),minus(times(times(times(2,plus(j,rdivide(3,2))),transpose(x)),PNxa(:,plus(j,2))),times(plus(j,2),PNxa(:,plus(j,1)))));
end
% j;
else
end
% if;
mc_t241 = plus(n,1);
mc_t269 = 1;
for j = (mc_t269 : mc_t241);
PNxa(:, j) = times(PNxa(:, j),sqrt(minus(j,rdivide(1,2))));
end
% j;
end

