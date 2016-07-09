function hidden_weights = bp_core(input_units,hidden_units,input_weights,in,hid,out,output_delta,target,output_units,hidden_delta,hidden_prev_weights,input_prev_weights,hidden_weights)
% bpnn_train_kernel;
[input_units, hidden_units] = bpnn_layerforward(input_units, hidden_units, input_weights, in, hid);
[hidden_units, output_units] = bpnn_layerforward(hidden_units, output_units, hidden_weights, hid, out);
[out_err, output_delta] = bpnn_output_error(output_delta, target, output_units, out);
[hid_err, hidden_delta] = bpnn_hidden_error(hidden_delta, hid, output_delta, out, hidden_weights, hidden_units);
[hidden_units, hidden_weights, hidden_prev_weights] = bpnn_adjust_weights(output_delta, out, hidden_units, hid, hidden_weights, hidden_prev_weights);
[input_units, input_weights, input_prev_weights] = bpnn_adjust_weights(hidden_delta, hid, input_units, in, input_weights, input_prev_weights);
end

function [errsum,delta_h] = bpnn_hidden_error(delta_h,nh,delta_o,no,who,hidden)
errsum = 0.0;
mc_t82 = 2;
for j = (mc_t82 : nh);
h = hidden(j);
s = 0.0;
k = colon(2,no);
delta_h(j) = times(times(h,minus(1.0,h)),plus(s,sum(times(delta_o(k),who(j, k)))));
errsum = plus(errsum,abs(delta_h(j)));
end
end

function [l1,l2] = bpnn_layerforward(l1,l2,conn,n1,n2)
mc_t63 = 1;
l1(mc_t63) = 1.0;
mc_t67 = 2;
for j = (mc_t67 : n2);
s = 0;
%sum;
mc_t64 = 1;
for k = (mc_t64 : n1);
s = plus(s,times(conn(k, j),l1(k)));
end
l2(j) = rdivide(1.0,plus(1.0,exp(uminus(s))));
end
end

function [ly,w,oldw] = bpnn_adjust_weights(delta,ndelta,ly,nly,w,oldw)
mc_t105 = 1;
ly(mc_t105) = 1.0;
mc_t107 = 2;
for j = (mc_t107 : ndelta);
mc_t106 = 1;
for k = (mc_t106 : nly);
new_dw = plus(times(times(0.3,delta(j)),ly(k)),times(0.3,oldw(k, j)));
w(k, j) = plus(w(k, j),new_dw);
oldw(k, j) = new_dw;
end
end
end

function [errsum,delta] = bpnn_output_error(delta,target,output,nj)
errsum = 0.0;
j = colon(2,nj);
%mc_t88 = errsum;;
o = output(j);
if length(delta)==length(j)
delta=times(times(o,minus(1.0,o)),minus(target(j),o));
else
delta(j)=times(times(o,minus(1.0,o)),minus(target(j),o));
end
%[errsum] = plus(mc_t88, mc_t89);;
errsum = plus(errsum,sum(abs(delta(j))));
end

