FFT (Fast Fourier Transform)
============================

Performs the Fast Fourier Transform (FFT) function on a random data set.

Note: This application was taken from the SHOC suite
      (http://ft.ornl.gov/doku/shoc/).
------------------------------
      
Why slowdown?

1. The length of loop 


Original code:
==========================

      (loop 1)
      for k=1:N
          rtnR(i,k) = resR(k);
          rtnI(i,k) = resI(k);
      end


Vectorized code:
==========================
      k = colon(1,N);
      rtnI(i, k) = resI(k);
      rtnR(i, k) = resR(k);

