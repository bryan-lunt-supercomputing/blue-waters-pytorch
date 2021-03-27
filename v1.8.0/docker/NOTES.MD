We are building a docker container with pytorch in it that can be used in shifter jobs on BW.

https://bluewaters.ncsa.illinois.edu/liferay-content/document-library/Documentation%20Documents/Webinars/User%20Teleconference%20Presentations/2017/Shifter_demo.pdf


pytorch/pytorch:1.8.0-cuda11.1-cudnn8-devel

Does not work, because "Kernel too old", it must have too new a glibc.

We need to build our own version, but based on centos7, this might be easy, since torch provides the build scripts and everything is nicely parameterized.

ubuntu:16.04 works on BW.
    So, lets build a pytorch docker container using their unmodified scripts, but ask for ubuntu 16.04 instead of 18.xxx
    
    nvidia/cuda:11.2.1-cudnn8-devel-ubuntu16.04


#MPI

    We need to make sure that there are mpi libraries that match BW so we can compile with mpi.
