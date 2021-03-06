function [elapsedTime] = runBlkSchls_new(numOptions,otype,sptprice,strike,rate,volatility,otime,DGrefval)
%INTEGER(KIND=4) :: count1, count2, count_max, count_rate
numError = 0;
ERR_CHK  = 0;
writeOut = 0;

prices = zeros(1,numOptions);

fprintf('runBlkSchls_new: loop (v) = %d \n', numOptions);
tic(); %tic()
% old
%for i=1:numOptions
%prices(i) = BlkSchls(sptprice(i), strike(i), rate(i), volatility(i), otime(i), otype(i), 0);
%if ERR_CHK == 1
%    priceDelta = DGrefval(i) - prices(i);
%    if priceDelta >= 1e-5
%        fprintf('error at %d\n',i);
%        numError = numError + 1;
%    end
%end
%end
% new
i = colon(1,numOptions);
prices(i)=BlkSchls(sptprice(i),strike(i),rate(i),volatility(i),otime(i),otype(i),0);
%

elapsedTime = toc();

% if writeOut == 1
% fprintf('elapsed time is %f s\n',elapsedTime);
% WritePrice(prices, strcat('output_runBlkSchls_',char(fileNames(opt))));
% end

% if ERR_CHK == 1
% fprintf('total error number is %d\n',numError);
% end

end


function OptionPrice = BlkSchls(sptprice,strike,rate,volatility,time,otype,timet)
xStockPrice  = sptprice;
xStrikePrice = strike;
xRiskFreeRate= rate;
xVolatility  = volatility;

xTime      = time; xSqrtTime = sqrt(xTime);
xLogTerm   = log( sptprice ./ strike );
xPowerTerm = xVolatility .* xVolatility .* 0.5;

xDen = xVolatility .* xSqrtTime;
xD1  = ((xRiskFreeRate + xPowerTerm) .* xTime + xLogTerm) ./ xDen;
xD2  = xD1 -  xDen;

NofXd1 = CNDF( xD1 );
NofXd2 = CNDF( xD2 );

FutureValueX = strike .* ( exp( -(rate).*(time) ) );

% old
%if otype == 0
%OptionPrice = (sptprice * NofXd1) - (FutureValueX * NofXd2);
%else
%NegNofXd1 = (1.0 - NofXd1);
%NegNofXd2 = (1.0 - NofXd2);
%OptionPrice = (FutureValueX * NegNofXd2) - (sptprice * NegNofXd1);
%end
% new
thenCond = eq(otype,0);
elseCond = not(thenCond);
OptionPrice = plus(times(elseCond,minus(times(elseCond,times(FutureValueX,times(elseCond,minus(times(elseCond,1.0),NofXd2)))),times(elseCond,times(sptprice,times(elseCond,minus(times(elseCond,1.0),NofXd1)))))),times(thenCond,minus(times(thenCond,times(sptprice, NofXd1)),times(thenCond,times(FutureValueX, NofXd2)))));

end
function OutputX = CNDF(InputX)
inv_sqrt_2xPI = 0.39894228040143270286;
% old
%if InputX < 0
%InputX = - InputX; sign = 1;
%else
%sign = 0;
%end
%xInput = InputX;
% new
thenCond = lt(InputX,0);
elseCond = not(thenCond);
InputX = plus(times(InputX,elseCond),times(thenCond,uminus(InputX)));
%

expValues = exp(-0.5 .* InputX .* InputX);
xNPrimeofX = expValues * inv_sqrt_2xPI;

xK2   = 1 ./ (1 + 0.2316419 .* InputX);
xK2_2 = xK2 .* xK2;
xK2_3 = xK2_2 .* xK2;
xK2_4 = xK2_3 .* xK2;
xK2_5 = xK2_4 .* xK2;

xLocal_1 = xK2 .* 0.319381530;
xLocal_2 = xK2_2 .* (-0.356563782);
xLocal_3 = xK2_3 .* 1.781477937;
xLocal_2 = xLocal_2 + xLocal_3;
xLocal_3 = xK2_4 .* (-1.821255978);
xLocal_2 = xLocal_2 + xLocal_3;
xLocal_3 = xK2_5 .* 1.330274429;
xLocal_2 = xLocal_2 + xLocal_3;

xLocal   = 1.0 - (xLocal_2 + xLocal_1) .* xNPrimeofX;
OutputX  = xLocal;

% old
%if sign == 1
%OutputX = 1.0 - OutputX;
%end
% new
thenCond = eq(plus(times(elseCond,0),times(thenCond,1)),1);
OutputX = plus(times(OutputX,not(thenCond)),times(thenCond,minus(times(thenCond,1.0),OutputX)));
%
end
