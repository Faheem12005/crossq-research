#!/bin/bash
export WANDB_API_KEY="8cd0d2c0744b9a344de8d0bba9b233dba070d297"
SEED=9
ENV="HalfCheetah-v4"
WANDB_MODE="online"
WANDB_ENTITY="mohdfaheem-1205-vellore-institute-of-technology"
WANDB_PROJECT="crossq"
ALGOS=("redq" "droq" "td3")

for ALGO in "${ALGOS[@]}"; do
  python train.py -algo $ALGO -env $ENV -seed $SEED \
    -wandb_mode $WANDB_MODE -wandb_entity $WANDB_ENTITY -wandb_project $WANDB_PROJECT \
    --exploration_bonus 0
  echo "Finished $ALGO baseline"
done
