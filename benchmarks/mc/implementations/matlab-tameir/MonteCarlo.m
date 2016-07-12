function [piValue] = MonteCarlo(inputData)
  mc_t29 = 2;
  [n] = size(inputData, mc_t29);
  mc_t30 = 1;
  [sampleOut] = zeros(mc_t30, n);
  mc_t33 = 1;
  for k = (mc_t33 : n);
    mc_t31 = 1;
    [mc_t23] = inputData(mc_t31, k);
    mc_t32 = 2;
    [mc_t24] = inputData(mc_t32, k);
    [mc_t22] = SampleFunc(mc_t23, mc_t24);
    sampleOut(k) = mc_t22;
  end
  reduceCount = 0;
  mc_t34 = 1;
  for k = (mc_t34 : n);
    mc_t25 = reduceCount;
    [mc_t26] = sampleOut(k);
    [reduceCount] = plus(mc_t25, mc_t26);
  end
  mc_t35 = 4;
  [mc_t27] = mtimes(mc_t35, reduceCount);
  mc_t28 = n;
  [piValue] = mrdivide(mc_t27, mc_t28);
end
function [z] = SampleFunc(a, b)
  mc_t40 = 2;
  [mc_t38] = mpower(a, mc_t40);
  mc_t41 = 2;
  [mc_t39] = mpower(b, mc_t41);
  [mc_t36] = plus(mc_t38, mc_t39);
  mc_t43 = 1;
  [mc_t42] = lt(mc_t36, mc_t43);
  if mc_t42
    z = 1;
  else 
    z = 0;
  end
end
