#!/bin/bash
echo 'BaRF job started'
EXP=$1
NAME=$2
source /users/visics/gkouros/.bashrc
export PATH="/usr/local/cuda-11/bin:/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-11/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
conda activate barf-env
dir=/users/visics/gkouros/projects/nerf-repos/bundle-adjusting-NeRF/
cd $dir

python3 train.py --group=$2 --model=barf --yaml=barf_iphone --name=$1 --data.scene=chrysler --barf_c2f=[0.1,0.5]
python3 evaluate.py --group=$2 --model=barf --yaml=barf_iphone --name=$1 --data.scene=chrysler --resume


conda deactivate
echo 'BaRF job terminated'
