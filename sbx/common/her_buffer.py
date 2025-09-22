import numpy as np
from stable_baselines3.common.buffers import ReplayBuffer

class HerReplayBuffer(ReplayBuffer):
    def __init__(self, buffer_size, observation_space, action_space,
                 her_ratio=0.8, strategy="future", reward_fn=None, **kwargs):
        super().__init__(buffer_size, observation_space, action_space, **kwargs)
        self.her_ratio = her_ratio
        self.strategy = strategy
        self.reward_fn = reward_fn  # custom reward recomputation fn

    def sample(self, batch_size, env=None):
        # Normal sampling
        batch = super().sample(batch_size, env)

        # Decide which samples to relabel
        n_her = int(self.her_ratio * batch_size)
        idxs = np.random.choice(batch_size, n_her, replace=False)

        for i in idxs:
            # Relabel goal: pick a future achieved_goal
            ep_idx = batch.episode_indices[i]
            future_idx = np.random.randint(i, self.pos) if self.strategy == "future" else self.pos - 1
            new_goal = self.observations["achieved_goal"][future_idx]

            # Replace desired_goal in observation/next_obs
            batch.observations[i]["desired_goal"] = new_goal
            batch.next_observations[i]["desired_goal"] = new_goal

            # Recompute reward
            batch.rewards[i] = self.reward_fn(
                batch.next_observations[i]["achieved_goal"],
                new_goal,
                batch.infos[i],
            )

        return batch
