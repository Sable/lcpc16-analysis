function [errsum,delta] = bpnn_output_error(delta,target,output,nj)
errsum = 0.0;
%fprintf('bpnn_output_error: loop1 = %d\n', nj-1);
% old
%for j = 2:nj
%    o = output(j);
%    t = target(j);
%    delta(j) = o * (1.0 - o) * (t - o);
%    errsum = errsum + abs(delta(j));
%end
% new
j = colon(2,nj);
o = output(j);
delta(j)=times(times(o,minus(1.0,o)),minus(target(j),o));
errsum = plus(errsum,sum(abs(delta(j))));
%
end
