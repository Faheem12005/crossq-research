#!/bin/bash
SEED=9
ENV="HalfCheetah-v4"
WANDB_MODE="online"
WANDB_ENTITY="mohdfaheem-1205-vellore-institute-of-technology"
WANDB_PROJECT="crossq"
BETAS=(0.1 0.2 0.5)

for BETA in "${BETAS[@]}"; do
  LOG="logs/crossq_${ENV}_bonus_beta${BETA}_seed${SEED}.out"
  python train.py -algo crossq -env $ENV -seed $SEED \
    -wandb_mode $WANDB_MODE -wandb_entity $WANDB_ENTITY -wandb_project $WANDB_PROJECT \
    --exploration_bonus 1 --beta $BETA > $LOG 2>&1
  echo "Finished crossq with exploration bonus beta=$BETA (log: $LOG)"
done
