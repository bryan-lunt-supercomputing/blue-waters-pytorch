#!/bin/sh
#PBS -l nodes=01:ppn=32:xe
#PBS -l walltime=02:00:00
#PBS -l gres=shifter
####PBS -N your_job_name
####PBS -e $PBS_JOBID.err
####PBS -o $PBS_JOBID.out
####PBS -m bea
##PBS -M YOUR_NETID@illinois.edu

module load shifter
cd ${PBS_O_WORKDIR}

shifterimg pull luntlab/bw-pytorch:v1.5.0-devel

aprun -b -- shifter --image=docker:luntlab/bw-pytorch:v1.5.0-devel --module=mpich -- python dist_mpi.py
