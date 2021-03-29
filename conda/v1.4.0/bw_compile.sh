#!/bin/bash

#PBS -q high
#PBS -lnodes=1:ppn=16,walltime=20:00:00

INSTALL_BASEDIR=/projects/eot/bbey/bjlunt2_installs
INSTALL_CONDA_BASE=/projects/eot/bbey/bjlunt2_installs/miniconda3
INSTALL_CONDA_ENV_NAME="torch141"

INSTALL_CONDA_ENV_PATH=${INSTALL_CONDA_BASE}/envs/${INSTALL_CONDA_ENV_NAME}

PYTORCH_SOURCE_DIR=/projects/eot/bbey/bjlunt2_installs/src/pytorch


#
#Remember to get cuDNN and NCCL and those will get installed in the environment's include and lib paths.
#

module load gcc/5.3.0 cmake/3.9.4 cudatoolkit/9.1.85_3.10-1.0502.df1cc54.3.1 cray-libsci/18.12.1 
source ${INSTALL_CONDA_BASE}/bin/activate
source activate ${INSTALL_CONDA_ENV_NAME}

#TODO: compile/tune numpy/scipy to use the cray-libsci implementations of BLAS

#conda install hdf5
#conda install numpy ninja pyyaml mkl mkl-include setuptools cmake cffi
#conda install -c pytorch magma-cuda90
#pip install wandb

cd ${PYTORCH_SOURCE_DIR}

#git checkout v1.4.0
#git submodule sync
#git submodule update --init --recursive

#TODO: Remember to apply patch
# git apply ../blue-waters-pytorch/pt-bw.patch


#Basic compiler things
export CC=gcc
export CXX=g++

#Building for our Conda installation.
export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}

#
#options for CPU
#
export USE_MKLDNN=1
export MKLDNN_THREADING=OMP


#
#OPTIONS FOR CUDA
#
export USE_CUDA=1
export TORCH_CUDA_ARCH_LIST="3.5" #NVIDIA GK110 (K20X) "Kepler" GPUs on Blue Waters

#export CUDNN_LIB_DIR="/projects/eot/bbcj/bjlunt2/src/cuda/lib64"
#export CUDNN_INCLUDE_DIR="/projects/eot/bbcj/bjlunt2/src/cuda/include"
export CUDNN_LIB_DIR=${INSTALL_CONDA_ENV_PATH}/lib
export CUDNN_INCLUDE_DIR=${INSTALL_CONDA_ENV_PATH}/include

#CUDNN_INCLUDE_PATH

export USE_SYSTEM_NCCL=1
#export NCCL_ROOT="/projects/eot/bbcj/bjlunt2/src/nccl_2.1.15-1+cuda9.1_x86_64"
#export NCCL_LIB_DIR="/projects/eot/bbcj/bjlunt2/src/nccl_2.1.15-1+cuda9.1_x86_64/lib"
#export NCCL_INCLUDE_DIR="/projects/eot/bbcj/bjlunt2/src/nccl_2.1.15-1+cuda9.1_x86_64/include"

#I copied the NCCL to here to make things self-contained. The build scripts won't build unless there is a complete NCCL directory. Copying the libs/includes doesn7t work.
export NCCL_ROOT=${INSTALL_CONDA_ENV_PATH}/share/nccl
export NCCL_LIB_DIR=${NCCL_ROOT}/lib
export NCCL_INCLUDE_DIR=${NCCL_ROOT}/include

#
#Other Options
#
export BUILD_CAFFE2_OPS=0


# Are we running on the headnode or in a PBS JOB on BW?
if [[ -z "${PBS_JOBID}" ]]; then
	RUN_WRAPPER=""
	export MAX_JOBS=8
else
	RUN_WRAPPER="aprun -d ${PBS_NUM_PPN} "
	export MAX_JOBS=${PBS_NUM_PPN}
fi

#CC=gcc CXX=g++ MAX_JOBS=64 USE_CUDA=1 BUILD_CAFFE2_OPS=0 USE_SYSTEM_NCCL=1 USE_MKLDNN=1 MKLDNN_THREADING=OMP aprun -d ${PBS_NUM_PPN} python setup.py build --verbose #2>&1 > compilation_log.txt
#BUILD_CAFFE2_OPS=0 USE_SYSTEM_NCCL=1 USE_CUDA=1 TORCH_CUDA_ARCH_LIST="3.5" USE_MKLDNN=1 MKLDNN_THREADING=OMP CC=gcc CXX=g++ MAX_JOBS=8 python setup.py build --verbose #2>&1 > compilation_log.txt
${RUN_WRAPPER} python setup.py install --verbose #2>&1 > compilation_log.txt
