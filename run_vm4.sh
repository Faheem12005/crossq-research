#!/bin/bash
SEED=9
ENV="HalfCheetah-v4"
WANDB_MODE="online"
WANDB_ENTITY="mohdfaheem-1205-vellore-institute-of-technology"
WANDB_PROJECT="crossq"
ALGOS=("redq" "droq" "td3")

for ALGO in "${ALGOS[@]}"; do
  LOG="logs/${ALGO}_${ENV}_baseline_seed${SEED}.out"
  python train.py -algo $ALGO -env $ENV -seed $SEED \
    -wandb_mode $WANDB_MODE -wandb_entity $WANDB_ENTITY -wandb_project $WANDB_PROJECT \
    --exploration_bonus 0 > $LOG 2>&1
  echo "Finished $ALGO baseline (log: $LOG)"
done
