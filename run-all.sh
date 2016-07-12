#!/bin/bash
echo cleaning
wu run --clean

nn=1
#JIT off
#cc="matlab-2013"
#JIT on
#cc="matlab-2013 matlab-vm"
#ii="-i matlab -i matlab-plus -i matlab-plus-no -i matlab-mixed"
cc="octave-4.0"
ii="-i matlab -i matlab-mixed"

echo $(date +"%T")
wu run backprop     $cc $ii -n $nn
wu run blackscholes $cc $ii -n $nn
wu run capr         $cc $ii -n $nn
wu run crni         $cc $ii -n $nn
wu run fft          $cc $ii -n $nn
#wu run lgdr         $cc $ii -n $nn
wu run pagerank     $cc $ii -n $nn
wu run mc           $cc $ii -n $nn
wu run nw           $cc $ii -n $nn
wu run spmv         $cc $ii -n $nn
echo $(date +"%T")

#echo $(date +"%T")
#wu run blackscholes octave -n $n
#echo $(date +"%T")
echo done!

