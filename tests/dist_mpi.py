#!/usr/bin/env python
import os
import torch
import torch.distributed as dist
from torch.multiprocessing import Process

if torch.cuda.is_available():
  print("CUDA Available")
  torch.set_default_tensor_type('torch.cuda.FloatTensor')
else:
  print("CUDA UN-Available")

def run(rank, size):
    tensor = torch.zeros(1)
    if rank == 0:
        tensor += 1
        # Send the tensor to process 1
        dist.send(tensor=tensor, dst=1)
    else:
        # Receive tensor from process 0
        dist.recv(tensor=tensor, src=0)
    print('Rank ', rank, ' has data ', tensor[0])

def init_process(rank, size, fn, backend='gloo'):
    """ Initialize the distributed environment. """
    #os.environ['MASTER_ADDR'] = '127.0.0.1'
    #os.environ['MASTER_PORT'] = '29500'
    dist.init_process_group(backend, rank=rank, world_size=size)
    fn(rank, size)


if __name__ == "__main__":
    init_process(0, 0, run, backend='mpi')
