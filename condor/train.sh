#!/bin/bash
NAME=$1
EXP=$2

source ~/miniconda3/etc/profile.d/conda.sh
conda activate barf-env

export PATH="/usr/local/cuda-11/bin:/usr/local/cuda/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-11/lib64:/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

conda activate barf-env

dir=/users/visics/gkouros/projects/nerf-repos/bundle-adjusting-NeRF/
cd $dir
mkdir -p output/$NAME/$EXP
python3 train.py \
  --group=$NAME \
  --model=barf \
  --yaml=barf_llff \
  --name=$EXP \
  --data.scene=$NAME \
  --barf_c2f=[0.1,0.5] \
  --visdom! && \

python3 evaluate.py \
  --group=$NAME \
  --model=barf \
  --yaml=barf_llff \
  --name=$EXP \
  --data.scene=$NAME \
  --resume


conda deactivate
