function [z] = SampleFunc(a, b)
%if (a^2 + b^2) < 1
%    z = 1;
%else
%    z = 0;
%end
thenCond = lt(plus(power(a,2),power(b,2)),1);
z = plus(times(not(thenCond),0),times(thenCond,1));
end
