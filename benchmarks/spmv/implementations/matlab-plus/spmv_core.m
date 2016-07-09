function res = spmv_core(dim,csr_num_rows,csr_Ap,csr_Ax,csr_Aj,vec)
tot = zeros(1,dim);
res = zeros(1,dim);
mc_t19 = 1;
for row = (mc_t19 : csr_num_rows);
temp = 0;
jj = colon(csr_Ap(row),csr_Ap(plus(row,1)));
res(row) = plus(temp,sum(times(csr_Ax(jj),vec(csr_Aj(jj)))));
end
end

