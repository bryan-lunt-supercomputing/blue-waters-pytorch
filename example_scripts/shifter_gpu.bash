#!/bin/bash
#PBS -l walltime=10:30:0,nodes=1:xk:ppn=16,gres=shifter

module load shifter

shifterimg pull luntlab/bw-pytorch:v1.5.0


#pytorch CPU operations are backed by MKL and OpenMP, if you don't bind to the
#correct number of CPUs/Cores with aprun, your application will be
#restricted to using a single core. This is slow and wasteful.

#Even if you are using GPU, you will still have various CPU threads.
export OMP_NUM_THREADS=16
aprun -b -n 1 -d 16  -- shifter --image=docker:luntlab/bw-pytorch:v1.5.0 --module=mpich,gpu -- python -c "import torch; print(torch.cuda.is_available());"
