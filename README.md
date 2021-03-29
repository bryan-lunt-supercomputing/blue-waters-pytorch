# blue-waters-pytorch
Building pytorch to use on Blue Waters.

## Shifter (docker) images (recommended)

The easiest way, when the admins have Shifter working, is to use one of the images.

https://hub.docker.com/repository/docker/luntlab/bw-pytorch/general

    - v1.5.0
        Works with CUDA.
        Works with MPI.
        Does NOT do MPI and CUDA together. (yet)
        Has MKL DNN support. etc.
    - v1.8.0
        Newest pytorch api (so far).
        No CUDA (effectively, see below.)
        May eventually have MPI support.
        Trying to make MKL DNN work.
        
        This image was compiled with cudatoolkit 10.2 . That will not work with the old nvidia drivers on BW. (At the time of this writing.) If they upgrade the driver (will never happen) it might start working. Compiling it in represents hope, I guess.
        
        



## Miniconda3 based native install (Works but out of date)


- Currently only supports version 1.4.0 .
- You have to manually install cudnn and nccl, unless they eventually make these packages for us.
