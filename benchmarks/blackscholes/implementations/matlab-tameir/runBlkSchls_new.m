function [elapsedTime] = runBlkSchls_new(numOptions, otype, sptprice, strike, rate, volatility, otime, DGrefval)
%INTEGER(KIND=4) :: count1, count2, count_max, count_rate
  numError = 0;
  ERR_CHK = 0;
  writeOut = 0;
% pass shape information
% otype      = reshape(otype      ,1,numOptions);
% sptprice   = reshape(sptprice   ,1,numOptions);
% strike     = reshape(strike     ,1,numOptions);
% rate       = reshape(rate       ,1,numOptions);
% volatility = reshape(volatility ,1,numOptions);
% otime      = reshape(otime      ,1,numOptions);
% DGrefval   = reshape(DGrefval   ,1,numOptions);
  mc_t69 = 1;
  [prices] = zeros(mc_t69, numOptions);
%CALL SYSTEM_CLOCK(count1, count_rate, count_max)
  tic(); % [] = ...
%tic()
  mc_t72 = 1;
  for i = (mc_t72 : numOptions);
    [mc_t63] = sptprice(i);
    [mc_t64] = strike(i);
    [mc_t65] = rate(i);
    [mc_t66] = volatility(i);
    [mc_t67] = otime(i);
    [mc_t68] = otype(i);
    mc_t71 = 0;
    [mc_t62] = BlkSchls(mc_t63, mc_t64, mc_t65, mc_t66, mc_t67, mc_t68, mc_t71);
    prices(i) = mc_t62;
%if ERR_CHK == 1
%    priceDelta = DGrefval(i) - prices(i);
%    if priceDelta >= 1e-5
%        fprintf('error at %d\n',i);
%        numError = numError + 1;
%    end
%end
  end
  [elapsedTime] = toc();
%CALL SYSTEM_CLOCK(count2, count_rate, count_max)
%elapsedTime = DBLE(count2 - count1) / DBLE(count_rate)
% if writeOut == 1
% fprintf('elapsed time is %f s\n',elapsedTime);
% WritePrice(prices, strcat('output_runBlkSchls_',char(fileNames(opt))));
% end
% if ERR_CHK == 1
% fprintf('total error number is %d\n',numError);
% end
end
function [OutputX] = CNDF(InputX)
  inv_sqrt_2xPI = 0.39894228040143270286;
  mc_t110 = 0;
  [mc_t109] = lt(InputX, mc_t110);
  if mc_t109
    [InputX] = uminus(InputX);
    sign = 1;
  else 
    sign = 0;
  end
  xInput = InputX;
  mc_t111 = 0.5;
  [mc_t98] = uminus(mc_t111);
  mc_t99 = InputX;
  [mc_t96] = mtimes(mc_t98, mc_t99);
  mc_t97 = InputX;
  [mc_t95] = mtimes(mc_t96, mc_t97);
  [expValues] = exp(mc_t95);
  [xNPrimeofX] = mtimes(expValues, inv_sqrt_2xPI);
  mc_t112 = 0.2316419;
  [mc_t101] = mtimes(mc_t112, xInput);
  mc_t113 = 1;
  [mc_t100] = plus(mc_t113, mc_t101);
  mc_t114 = 1;
  [xK2] = mrdivide(mc_t114, mc_t100);
  [xK2_2] = mtimes(xK2, xK2);
  [xK2_3] = mtimes(xK2_2, xK2);
  [xK2_4] = mtimes(xK2_3, xK2);
  [xK2_5] = mtimes(xK2_4, xK2);
  mc_t115 = 0.319381530;
  [xLocal_1] = mtimes(xK2, mc_t115);
  mc_t102 = xK2_2;
  mc_t116 = 0.356563782;
  [mc_t103] = uminus(mc_t116);
  [xLocal_2] = mtimes(mc_t102, mc_t103);
  mc_t117 = 1.781477937;
  [xLocal_3] = mtimes(xK2_3, mc_t117);
  [xLocal_2] = plus(xLocal_2, xLocal_3);
  mc_t104 = xK2_4;
  mc_t118 = 1.821255978;
  [mc_t105] = uminus(mc_t118);
  [xLocal_3] = mtimes(mc_t104, mc_t105);
  [xLocal_2] = plus(xLocal_2, xLocal_3);
  mc_t119 = 1.330274429;
  [xLocal_3] = mtimes(xK2_5, mc_t119);
  [xLocal_2] = plus(xLocal_2, xLocal_3);
  [mc_t107] = plus(xLocal_2, xLocal_1);
  mc_t108 = xNPrimeofX;
  [mc_t106] = mtimes(mc_t107, mc_t108);
  mc_t120 = 1.0;
  [xLocal] = minus(mc_t120, mc_t106);
  OutputX = xLocal;
  mc_t123 = 1;
  [mc_t122] = eq(sign, mc_t123);
  if mc_t122
    mc_t121 = 1.0;
    [OutputX] = minus(mc_t121, OutputX);
  else 
  end
end
function [OptionPrice] = BlkSchls(sptprice, strike, rate, volatility, time, otype, timet)
  xStockPrice = sptprice;
  xStrikePrice = strike;
  xRiskFreeRate = rate;
  xVolatility = volatility;
  xTime = time;
  [xSqrtTime] = sqrt(xTime);
  [mc_t73] = mrdivide(sptprice, strike);
  [xLogTerm] = log(mc_t73);
  [mc_t74] = mtimes(xVolatility, xVolatility);
  mc_t90 = 0.5;
  [xPowerTerm] = mtimes(mc_t74, mc_t90);
  [xDen] = mtimes(xVolatility, xSqrtTime);
  [mc_t79] = plus(xRiskFreeRate, xPowerTerm);
  mc_t80 = xTime;
  [mc_t77] = mtimes(mc_t79, mc_t80);
  mc_t78 = xLogTerm;
  [mc_t75] = plus(mc_t77, mc_t78);
  mc_t76 = xDen;
  [xD1] = mrdivide(mc_t75, mc_t76);
  [xD2] = minus(xD1, xDen);
  [NofXd1] = CNDF(xD1);
  [NofXd2] = CNDF(xD2);
  mc_t81 = strike;
  [mc_t84] = uminus(rate);
  mc_t85 = time;
  [mc_t83] = mtimes(mc_t84, mc_t85);
  [mc_t82] = exp(mc_t83);
  [FutureValueX] = mtimes(mc_t81, mc_t82);
  mc_t94 = 0;
  [mc_t93] = eq(otype, mc_t94);
  if mc_t93
    [mc_t86] = mtimes(sptprice, NofXd1);
    [mc_t87] = mtimes(FutureValueX, NofXd2);
    [OptionPrice] = minus(mc_t86, mc_t87);
  else 
    mc_t91 = 1.0;
    [NegNofXd1] = minus(mc_t91, NofXd1);
    mc_t92 = 1.0;
    [NegNofXd2] = minus(mc_t92, NofXd2);
    [mc_t88] = mtimes(FutureValueX, NegNofXd2);
    [mc_t89] = mtimes(sptprice, NegNofXd1);
    [OptionPrice] = minus(mc_t88, mc_t89);
  end
end
