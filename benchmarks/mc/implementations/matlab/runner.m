function runner(n)
    % feature accel off;
    %rng(100);
    rand("seed", 100);
    rdata = rand(2,n);
    n = 10;
    tic();
    piValue = MonteCarlo(rdata);
    elapsedTime=toc();
    fprintf('{ "time": %f, "pi": %f }\n',elapsedTime,piValue);
end