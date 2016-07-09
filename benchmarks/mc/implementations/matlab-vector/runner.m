function runner(n)
    %rng(100);
    rand("seed", 100); %set seed
    rdata = rand(2,n);
    n = 10;
    tic();
    piValue = MonteCarlo(rdata);
    elapsedTime=toc();
    fprintf('{ "time": %f, "pi": %f }\n',elapsedTime,piValue);
end
