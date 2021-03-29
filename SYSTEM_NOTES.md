
# Blue Waters

https://bluewaters.ncsa.illinois.edu/hardware-summary

### Cray XE/XK
	AMD 6276 "Interlagos"
	NVIDIA GK110 (K20X) "Kepler"
		This card was released on may 23rd, 2013, it supports CUDA 3.5 and OpenCL 1.2
		https://www.nvidia.com/content/pdf/kepler/tesla-k20x-bd-06397-001-v07.pdf
		https://www.techpowerup.com/gpu-specs/nvidia-gk110.g136

### CUDA Toolkit = 9.1
### Kernel = 3.0
	This implies that the best glibc we can run is _maybe_ 2.22 .
	Using shifter, I have gotten glibc 2.17 (ubuntu16.04) to run.
	All shifter images are based on that. centos7 also runs in shifter.
