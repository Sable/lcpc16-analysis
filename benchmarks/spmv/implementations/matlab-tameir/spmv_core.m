function [res] = spmv_core(dim, csr_num_rows, csr_Ap, csr_Ax, csr_Aj, vec)
  mc_t16 = 1;
  [tot] = zeros(mc_t16, dim);
  mc_t17 = 1;
  [res] = zeros(mc_t17, dim);
  mc_t19 = 1;
  for row = (mc_t19 : csr_num_rows);
    [row_start] = csr_Ap(row);
    mc_t18 = 1;
    [mc_t10] = plus(row, mc_t18);
    [row_end] = csr_Ap(mc_t10);
%res(row)  = sum(csr_Ax(row_start:row_end) .* vec(csr_Aj(row_start:row_end)));
    temp = 0;
    for jj = (row_start : row_end);
      mc_t11 = temp;
      [mc_t13] = csr_Ax(jj);
      [mc_t15] = csr_Aj(jj);
      [mc_t14] = vec(mc_t15);
      [mc_t12] = mtimes(mc_t13, mc_t14);
      [temp] = plus(mc_t11, mc_t12);
    end
    res(row) = temp;
  end
end
