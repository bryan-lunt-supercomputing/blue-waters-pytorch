
# Blue Waters

https://bluewaters.ncsa.illinois.edu/hardware-summary

Cray XE/XK
	AMD 6276 "Interlagos"
	NVIDIA GK110 (K20X) "Kepler"
		This card was released on may 23rd, 2013, it supports CUDA 3.5 and OpenCL 1.2
		https://www.nvidia.com/content/pdf/kepler/tesla-k20x-bd-06397-001-v07.pdf
		https://www.techpowerup.com/gpu-specs/nvidia-gk110.g136


## PATCH

I created the patch from the diffs listed here:
	https://github.com/spack/spack/pull/13588
	Related: https://github.com/pytorch/pytorch/issues/23482



## cuDNN

	https://developer.nvidia.com/rdp/cudnn-archive
	"Download cuDNN v7.1.3 (April 17, 2018), for CUDA 9.1"
		"cuDNN v7.1.3 Library for Linux"




## NCCL
	https://developer.nvidia.com/nccl/nccl-legacy-downloads
	"Download NCCL v2.1.15, for CUDA 9.1, March 8, 2018"
		"NCCL 2.1.15 O/S agnostic and CUDA 9"


	The provided NCCL can't (easily) compile on our system.
	Trying to use NCCL downloaded from NVIDIA. Too bad they make that difficult and encumbered.

	nccl_2.1.15-1+cuda9.1_x86_64.txz

	This is from the "legacy / old / whatever" downloads.


# Future
	It would be nice to link more tightly to tuned libraries provided by the vendor.
	https://bluewaters.ncsa.illinois.edu/libraries


