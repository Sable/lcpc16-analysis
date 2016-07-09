function [answer,reference] = needle(penalty,max_rows,max_cols,input_seq_1,input_seq_2,reference,input_itemsets,blosum62)
mc_t72 = 2;
for i = (mc_t72 : max_cols);
j = colon(2,max_rows);
reference(i, j) = blosum62(input_seq_2(j),input_seq_1(i));
end
i = colon(2,max_rows);
mc_t74 = 1;
input_itemsets(i, mc_t74) = times(uminus(minus(i,1)),penalty);
j = colon(2,max_cols);
mc_t77 = 1;
input_itemsets(mc_t77, j) = times(uminus(minus(j,1)),penalty);
mc_t84 = 2;
for i = (mc_t84 : max_rows);
mc_t83 = 2;
for j = (mc_t83 : max_cols);
input_itemsets(i, j) = max(max(plus(input_itemsets(minus(i,1),minus(j,1)),reference(i, j)),minus(input_itemsets(i,minus(j,1)),penalty)),minus(input_itemsets(minus(i,1),j),penalty));
end
end
answer = plus(input_itemsets,1);
end

