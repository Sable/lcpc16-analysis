function cap = capacitor(a,b,c,d,n,tol,rel)
%-----------------------------------------------------------------------;
%;
%	This function M-file computes the capacitance;
%	per unit length of a coaxial pair of rectangles.;
%;
%	Invocation:;
%		>> cap=capacitor(a, b, c, d, n, tol, rel);
%;
%		where;
%;
%		i. a is the width of the inner conductor,;
%;
%		i. b is the height of the inner conductor,;
%;
%		i. c is the width of the outer conductor,;
%;
%		i. d is the height of the outer conductor,;
%;
%		i. n is the number of points along the x-axis,;
%;
%		i. tol is the tolerance,;
%;
%		i. rel is the relaxation parameter,;
%;
%		o. cap is the capacitance per unit length.;
%;
%	Requirements:;
%		None.;
%;
%	Examples:;
%		>> cap=capacitor(1, 2, 2, 3, 50, 1e-9, 1.90);
%;
%	Source:;
%		Computational Electromagnetics - EEK 170 course at;
%		http://www.elmagn.chalmers.se/courses/CEM/.;
%;
%-----------------------------------------------------------------------;
h = rdivide(times(0.5,c),n);
% Grid size.;
na = round(rdivide(times(0.5,a),h));
%x=linspace(0, 0.5*c, n+1);;
m = round(rdivide(times(0.5,d),h));
mb = round(rdivide(times(0.5,b),h));
%y=linspace(0, 0.5*d, m+1);;
% Initialize potential and mask array.;
f = zeros(plus(n,1),plus(m,1));
mask = times(ones(plus(n,1),plus(m,1)),rel);
mc_t168 = plus(na,1);
mc_t185 = 1;
for ii = (mc_t185 : mc_t168);
mc_t167 = plus(mb,1);
mc_t184 = 1;
for jj = (mc_t184 : mc_t167);
mask(ii, jj) = 0;
f(ii, jj) = 1;
end
end
oldcap = 0;
mc_t187 = 1;
mc_t188 = 1000;
for iter = (mc_t187 : mc_t188);
f = seidel(f, mask, n, m, na, mb);
cap = gauss(n, m, h, f);
mc_t186 = lt(rdivide(abs(minus(cap, oldcap)),cap),tol);
if mc_t186
break;;
else
oldcap = cap;
end
end
end

function f = seidel(f,mask,n,m,na,mb)
%-----------------------------------------------------------------------;
%;
%	This function M-file makes one Seidel iteration.;
%;
%	Invocation:;
%		>> g=seidel(f, mask, n, m, na, mb);
%;
%		where;
%;
%		i. f is the potential array,;
%;
%		i. mask is the mask array,;
%;
%		i. n is the number of points along the x-axis,;
%;
%		i. m is the number of points along the height of;
%		   the outer conductor,;
%;
%		i. na is the number of points along the width of;
%		   the inner conductor,;
%;
%		i. mb is the number of points along the height of;
%		   the inner conductor,;
%;
%		o. g is the updated potential array.;
%;
%	Requirements:;
%		None.;
%;
%	Source:;
%		Computational Electromagnetics - EEK 170 course at;
%		http://www.elmagn.chalmers.se/courses/CEM/.;
%;
%-----------------------------------------------------------------------;
mc_t283 = 2;
for ii = (mc_t283 : n);
mc_t282 = 2;
for jj = (mc_t282 : m);
f(ii, jj) = plus(f(ii, jj),times(mask(ii, jj),minus(times(0.25,plus(plus(plus(f(minus(ii,1),jj),f(plus(ii,1),jj)),f(ii,minus(jj,1))),f(ii,plus(jj,1)))),f(ii, jj))));
end
end
ii = 1;
% Symmetry on left boundary ii-1 -> ii+1.;
mc_t289 = 2;
for jj = (mc_t289 : m);
f(ii, jj) = plus(f(ii, jj),times(mask(ii, jj),minus(times(0.25,plus(plus(plus(f(plus(ii,1),jj),f(plus(ii,1),jj)),f(ii,minus(jj,1))),f(ii,plus(jj,1)))),f(ii, jj))));
end
jj = 1;
% Symmetry on lower boundary jj-1 -> jj+1.;
mc_t295 = 2;
for ii = (mc_t295 : n);
f(ii, jj) = plus(f(ii, jj),times(mask(ii, jj),minus(times(0.25,plus(plus(plus(f(minus(ii,1),jj),f(plus(ii,1),jj)),f(ii,plus(jj,1))),f(ii,plus(jj,1)))),f(ii, jj))));
end
end

function cap = gauss(n,m,h,f)
%-----------------------------------------------------------------------;
%;
%	This function M-file computes capacitance from the;
%	potential.;
%;
%	Invocation:;
%		>> cap=gauss(n, m, h, f);
%;
%		where;
%;
%		i. n is the number of points along the x-axis,;
%;
%		i. m is the number of points along the height of;
%		   the outer conductor,;
%;
%		i. f is the potential array,;
%;
%		i. h is the grid size,;
%;
%		o. cap is the capacitance.;
%;
%	Requirements:;
%		None.;
%;
%	Source:;
%		Computational Electromagnetics - EEK 170 course at;
%		http://www.elmagn.chalmers.se/courses/CEM/.;
%;
%-----------------------------------------------------------------------;
q = 0;
ii = colon(1,n);
%mc_t189 = q;;
%[q] = plus(mc_t189, mc_t190);;
q = plus(q,sum(times(plus(f(ii, m),f(plus(ii,1),m)),0.5)));
jj = colon(1,m);
%mc_t196 = q;;
%[q] = plus(mc_t196, mc_t197);;
cap = times(plus(q,sum(times(plus(f(n, jj),f(n,plus(jj,1))),0.5))),4);
% Four quadrants.;
cap = times(cap,8.854187);
end

