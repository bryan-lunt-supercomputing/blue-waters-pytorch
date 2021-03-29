#!/bin/sh
#PBS -l nodes=01:ppn=16:xk
#PBS -l walltime=02:00:00
#PBS -l gres=shifter
#PBS -v UDI=luntlab/bw-pytorch:v1.5.0
####PBS -N your_job_name
####PBS -e $PBS_JOBID.err
####PBS -o $PBS_JOBID.out
####PBS -m bea
##PBS -M YOUR_NETID@illinois.edu
export CRAY_ROOTFS=SHIFTER

#CUDA
PATH=$PATH:/opt/cray/nvidia/390.46-1_1.0502.2481.1.1.gem/bin
PATH=$PATH:/opt/nvidia/cudatoolkit9.1/9.1.85_3.10-1.0502.df1cc54.3.1/bin
export PATH

LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/nvidia/390.46-1_1.0502.2481.1.1.gem/lib64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/nvidia/cudatoolkit9.1/9.1.85_3.10-1.0502.df1cc54.3.1/lib64
export LD_LIBRARY_PATH
export CUDA_VISIBLE_DEVICES=0


#MPI
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/pmi/5.0.11/lib64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/libsci/18.12.1/GNU/5.1/x86_64/lib
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/mpt/7.7.4/gni/mpich-gnu-abi/5.1/lib
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/xpmem/0.1-2.0502.64982.7.27.gem/lib64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/dmapp/7.0.1-1.0502.11080.8.74.gem/lib64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/ugni/6.0-1.0502.10863.8.28.gem/lib64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/udreg/2.3.2-1.0502.10518.2.17.gem/lib64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/wlm_detect/1.0-1.0502.64649.2.2.gem/lib64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cray/alps/5.2.4-2.0502.9774.31.12.gem/lib64
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/udiImage/modules/mpich/lib64

export LD_LIBRARY_PATH

export MPICH_GNI_MALLOC_FALLBACK=1




cd ${PBS_O_WORKDIR}


aprun -b -n 2 -- bash -c "python ./dist_mpi.py"
