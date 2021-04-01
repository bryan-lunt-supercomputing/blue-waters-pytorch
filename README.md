# blue-waters-pytorch
Building pytorch to use on Blue Waters.

## Shifter (docker) images (recommended)

The easiest way, when the admins have Shifter working, is to use one of the images.

- luntlab/bw-pytorch:v1.5.0
- luntlab/bw-pytorch:v1.8.0


https://hub.docker.com/repository/docker/luntlab/bw-pytorch/general

    - v1.5.0
        Works with CUDA.
        Works with MPI.
        Does NOT do MPI and CUDA together. (yet)
        Has MKL DNN support. etc.
    - v1.8.0
        Newest pytorch api (so far).
        Compiled with MPI. (needs testing, probably works since the other one does).
        No CUDA (effectively, see below.)
        Has MKL DNN support. etc.
        
        This image was compiled with cudatoolkit 10.2 .
        That will not work with the old nvidia drivers on BW.
        (At the time of this writing.)
        If they upgrade the driver (will never happen) it might
        start working. Compiling it in represents hope, I guess.
        
        



## Miniconda3 based native install (Works but out of date)


- Currently only supports version 1.4.0 .
- You have to manually install cudnn and nccl, unless they eventually make these packages for us.

## Donations
In addition to the time spent on this, I incur non-negligible AWS costs every time I rebuild the images.

If you find this to be useful, please consider sending me a few dollars to offset my AWS costs.

https://paypal.me/bryanjlunt?locale.x=en_US
