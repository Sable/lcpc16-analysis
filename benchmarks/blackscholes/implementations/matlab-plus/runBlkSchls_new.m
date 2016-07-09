function elapsedTime = runBlkSchls_new(numOptions,otype,sptprice,strike,rate,volatility,otime,DGrefval)
%INTEGER(KIND=4) :: count1, count2, count_max, count_rate;
numError = 0;
ERR_CHK = 0;
writeOut = 0;
% pass shape information;
% otype      = reshape(otype      ,1,numOptions);;
% sptprice   = reshape(sptprice   ,1,numOptions);;
% strike     = reshape(strike     ,1,numOptions);;
% rate       = reshape(rate       ,1,numOptions);;
% volatility = reshape(volatility ,1,numOptions);;
% otime      = reshape(otime      ,1,numOptions);;
% DGrefval   = reshape(DGrefval   ,1,numOptions);;
prices = zeros(1,numOptions);
%CALL SYSTEM_CLOCK(count1, count_rate, count_max);
tic();
% [] = ...;
% [] = ...;
%tic();
i = colon(1,numOptions);
if length(prices)==length(i)
prices=BlkSchls(sptprice(i),strike(i),rate(i),volatility(i),otime(i),otype(i),0);
else
prices(i)=BlkSchls(sptprice(i),strike(i),rate(i),volatility(i),otime(i),otype(i),0);
end
elapsedTime = toc();
%CALL SYSTEM_CLOCK(count2, count_rate, count_max);
%elapsedTime = DBLE(count2 - count1) / DBLE(count_rate);
% if writeOut == 1;
% fprintf('elapsed time is %f s\n',elapsedTime);;
% WritePrice(prices, strcat('output_runBlkSchls_',char(fileNames(opt))));;
% end;
% if ERR_CHK == 1;
% fprintf('total error number is %d\n',numError);;
% end;
end

function OutputX = CNDF(InputX)
thenCond = lt(InputX,0);
elseCond = not(thenCond);
InputX = plus(times(InputX,elseCond),times(thenCond,uminus(InputX)));
xK2 = rdivide(1,plus(1,times(0.2316419,InputX)));
xK2_2 = times(xK2, xK2);
xK2_3 = times(xK2_2, xK2);
xK2_4 = times(xK2_3, xK2);
xLocal_2 = times(xK2_2,uminus(0.356563782));
xLocal_2 = plus(xLocal_2,times(xK2_3,1.781477937));
xLocal_2 = plus(xLocal_2,times(xK2_4,uminus(1.821255978)));
OutputX = minus(1.0,times(plus(plus(xLocal_2,times(times(xK2_4, xK2),1.330274429)),times(xK2,0.319381530)),times(exp(times(times(uminus(0.5),InputX),InputX)),0.39894228040143270286)));
thenCond = eq(plus(times(elseCond,0),times(thenCond,1)),1);
OutputX = plus(times(OutputX,not(thenCond)),times(thenCond,minus(times(thenCond,1.0),OutputX)));
end

function OptionPrice = BlkSchls(sptprice,strike,rate,volatility,time,otype,timet)
xStockPrice = sptprice;
xStrikePrice = strike;
xVolatility = volatility;
xTime = time;
xDen = times(xVolatility,sqrt(xTime));
xD1 = rdivide(plus(times(plus(rate,times(times(xVolatility, xVolatility),0.5)),xTime),log(rdivide(sptprice, strike))),xDen);
NofXd1 = CNDF(xD1);
NofXd2 = CNDF(minus(xD1, xDen));
FutureValueX = times(strike,exp(times(uminus(rate),time)));
thenCond = eq(otype,0);
elseCond = not(thenCond);
OptionPrice = plus(times(elseCond,minus(times(elseCond,times(FutureValueX,times(elseCond,minus(times(elseCond,1.0),NofXd2)))),times(elseCond,times(sptprice,times(elseCond,minus(times(elseCond,1.0),NofXd1)))))),times(thenCond,minus(times(thenCond,times(sptprice, NofXd1)),times(thenCond,times(FutureValueX, NofXd2)))));
end

