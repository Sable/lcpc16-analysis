function [pageRanks,t,maxDiff] = pagerank(iter,thresh,pages,noutlinks,pageRanks,n)
maxDiff = 99;
dFactor = 0.85;
mc_t35 = 1;
for t = (mc_t35 : iter);
mc_t29 = lt(maxDiff, thresh);
if mc_t29
break;;
else
end
% map_page_rank;
mc_t31 = 1;
for i = (mc_t31 : n);
k = colon(1,n);
maps(i, k) = times(pages(i, k),rdivide(pageRanks(i),noutlinks(i)));
end
% reduce_page_rank;
dif = 0;
mc_t34 = 1;
for j = (mc_t34 : n);
newRank = plus(rdivide(minus(1,dFactor),n),times(dFactor,sum(maps(:, j))));
newDif = abs(minus(newRank,pageRanks(j)));
mc_t33 = gt(newDif, dif);
if mc_t33
dif = newDif;
else
end
pageRanks(j) = newRank;
end
maxDiff = dif;
end
end

