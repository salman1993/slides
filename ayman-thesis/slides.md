---
theme: seriph
title: "Addressing Different Goal Selection Strategies in HER"
info: |
  Addressing Different Goal Selection Strategies in Hindsight Experience Replay
  with Actor-Critic Methods for Robotic Hand Manipulation.
  RAAI '22 — Ayman Shams and Dr. Thomas Fevens
layout: center
class: text-center
colorSchema: light
background: none
themeConfig:
  primary: '#1a1a2e'
drawings:
  persist: false
transition: slide-left
mdc: true
fonts:
  sans: Work Sans
  mono: Space Mono
---

<div class="text-2xl font-bold leading-snug max-w-3xl mx-auto">
Addressing Different Goal Selection Strategies in Hindsight Experience Replay with Actor-Critic Methods for Robotic Hand Manipulation
</div>

<div class="mt-6 text-base opacity-80">
International Conference on Robotics, Automation and Artificial Intelligence (RAAI '22)
</div>

<div class="mt-6 text-sm opacity-60">

**Presenter:** Ayman Shams (SR582)

**Author:** Ayman Shams and Dr. Thomas Fevens

</div>

---

# Introduction

- Learning from sparse rewards is challenging for reinforcement learning algorithms
- Hindsight experience replay (HER) is a powerful solution to solve multi-goal RL with sparse rewards
- We present a combined technique of Twin Delayed DDPG (TD3) with Hindsight Experience Replay (HER)
- This combined technique allows for sample-efficient learning from sparse and binary rewards and avoids the need for complicated reward engineering

<!--
We will be trying to address this problem in our work.
Bear with me while I take you through our solution, environment settings and empirical results and future direction of the work from our lab.
-->

---

# RL Agent–Environment Loop

<div class="flex justify-center">
  <img src="/images/slide_03.png" class="h-96" />
</div>

<!--
Diagram of the RL feedback loop: DNN agent interacts with gym environment.
States include end effector position/velocity, gripper state, object position/rotation/velocity.
Actions are delta x/y/z of end-effector and gripper opening.
Rewards are sparse: 0 if near target, -1 otherwise.
-->

---

# Continuous Action Space

<div class="flex justify-center">
  <img src="/images/slide_04.png" class="h-96" />
</div>

<!--
Standard algorithms: REINFORCE, Actor-Critic.
Recent developments: DDPG, PPO, TD3, SAC.
-->

---

# DDPG

- A model-free off-policy algorithm for learning continuous action spaces
- Maintains two neural networks: a target policy (actor) and an action-value function approximator (critic)
- The critic's job is to approximate the actor's action value function Q
- Combines ideas from DPG (Deterministic Policy Gradient) and DQN (Deep Q-Network)
- Uses Experience Replay and slow-learning target networks from DQN, and is based on DPG which can operate over continuous action spaces

---

# TD3

The TD3 algorithm is an extension of DDPG. DDPG agents can overestimate value functions, which can produce suboptimal policies. To reduce this, TD3 includes:

<v-clicks>

- **Clipped Double Q-Learning** — learns two Q-value functions and uses the minimum value function estimate during policy updates
- **Delayed Policy Update** — updates the policy and targets less frequently than the Q functions
- **Target Policy Smoothing** — adds noise to the target action, making the policy less likely to exploit actions with high Q-value estimates

</v-clicks>

---

# Hindsight Experience Replay

<div class="flex justify-center">
  <img src="/images/slide_07.png" class="h-96" />
</div>

<!--
HER re-labels failed experiences by pretending the achieved goal was the intended goal.
Compatible with any off-policy RL algorithm.
Diagram shows robotic arm with red (failed goal) and green (virtual goal achieved).
-->

---

# Environment Settings

- We tested DDPG, TD3, DDPG+HER, TD3+HER on all 6 environments
- Close to a hundred hours of training overall
- All experiments were run for 50 epochs, amounting to 1e6 time-steps
- Comparative study of TD3+HER with final, episode and future goal strategies on fetch environments

---

# Fetch Environments

The fetch environment is based on a robotic arm with two parallel fingers for gripping (7 degrees of freedom).

Rewards are sparse and binary: -1 if object not within 5 cm tolerance, else 0.

<v-clicks>

- **Fetch Reach** — the gripper must be moved to the desired location
- **Fetch Push** — the robot must move a box to a specified point on the table
- **Fetch Slide** — the robot must strike a puck hard enough to slide and stop at the target location (target is out of reach)

</v-clicks>

---

# Shadow Dexterous Hand Environments

24 DOF anthropomorphic robotic hand (20 independent joints, 12 coupled).

<v-clicks>

- **Block Manipulation** — manipulate a block on the palm to achieve a target pose
  - Goal achieved if distance < 1 cm and rotation difference < 0.1 rad
- **Egg Manipulation** — similar to block task but with an egg-shaped object
- **Pen Manipulation** — grasp and manipulate a pen (can fall off or become lodged)
  - Goal achieved if distance < 5 cm from desired position

</v-clicks>

---

# Parameters

| Parameter | Value |
|-----------|-------|
| Policy | Multi-input |
| Architecture | 3-layer actor-critic, 256 units each |
| Activation | ReLU |
| Optimizer | Adam, lr = 1e-3 |
| Buffer size | 1e6 transitions |
| Batch size | 256 |
| Gamma | 0.95 |
| Exploration noise | Normal, SD = 0.2 |

Training hyperparameters obtained from RL Zoo.

---

# Fetch Environment Demos

<div class="grid grid-cols-3 gap-4">
  <div class="flex flex-col items-center">
    <div class="flex items-center justify-center h-52 border border-gray-300 rounded-lg w-full bg-gray-50">
      <p class="text-gray-400 italic text-sm">Add GIF: images/fetch_slide.gif</p>
    </div>
    <p class="mt-2 font-semibold text-sm">Fetch Slide</p>
  </div>
  <div class="flex flex-col items-center">
    <div class="flex items-center justify-center h-52 border border-gray-300 rounded-lg w-full bg-gray-50">
      <p class="text-gray-400 italic text-sm">Add GIF: images/fetch_push.gif</p>
    </div>
    <p class="mt-2 font-semibold text-sm">Fetch Push</p>
  </div>
  <div class="flex flex-col items-center">
    <div class="flex items-center justify-center h-52 border border-gray-300 rounded-lg w-full bg-gray-50">
      <p class="text-gray-400 italic text-sm">Add GIF: images/fetch_reach.gif</p>
    </div>
    <p class="mt-2 font-semibold text-sm">Fetch Reach</p>
  </div>
</div>

<!--
Slide 12 — GIF demos of the three fetch environments. Drop GIFs into images/ and replace placeholders with:
<img src="/images/fetch_slide.gif" class="h-52 rounded-lg" />
-->

---

# Hand Manipulation Demos

<div class="grid grid-cols-3 gap-4">
  <div class="flex flex-col items-center">
    <div class="flex items-center justify-center h-52 border border-gray-300 rounded-lg w-full bg-gray-50">
      <p class="text-gray-400 italic text-sm">Add GIF: images/hand_block.gif</p>
    </div>
    <p class="mt-2 font-semibold text-sm">Hand Block</p>
  </div>
  <div class="flex flex-col items-center">
    <div class="flex items-center justify-center h-52 border border-gray-300 rounded-lg w-full bg-gray-50">
      <p class="text-gray-400 italic text-sm">Add GIF: images/hand_egg.gif</p>
    </div>
    <p class="mt-2 font-semibold text-sm">Hand Egg</p>
  </div>
  <div class="flex flex-col items-center">
    <div class="flex items-center justify-center h-52 border border-gray-300 rounded-lg w-full bg-gray-50">
      <p class="text-gray-400 italic text-sm">Add GIF: images/hand_pen.gif</p>
    </div>
    <p class="mt-2 font-semibold text-sm">Hand Pen</p>
  </div>
</div>

<!--
Slide 13 — GIF demos of the three hand manipulation environments. Drop GIFs into images/ and replace placeholders with:
<img src="/images/hand_block.gif" class="h-52 rounded-lg" />
-->

---
layout: section
---

# Empirical Results

---

# Fetch Environment Results (TD3 Dense)

<div class="flex justify-center">
  <img src="/images/slide_14.png" class="h-96" />
</div>

<!--
Two TensorBoard plots over 1M timesteps: mean episode reward and success rate.
FetchReach converges quickly to 1.0 success rate.
FetchPush stays flat around 0.1 success rate.
FetchSlide gradually improves to ~0.15-0.20 success rate.
-->

---

# Hand Manipulation Results (TD3+HER Dense)

<div class="flex justify-center">
  <img src="/images/slide_15.png" class="h-96" />
</div>

<!--
Two TensorBoard plots: mean episode reward and success rate for egg, pen, block tasks.
Pen shows highest performance, block moderate, egg lowest.
Success rates are very low overall (<0.03).
-->

---

# Addressing Goal Selection Strategy

- **Episode** — replay with k random states from the same episode as the transition being replayed
- **Future** — replay with k random states from the same episode, observed after the transition
- **Final** — replay with k random states from the final episode

<!--
These three goal selection strategies determine how hindsight goals are sampled during experience replay.
-->

---

# Goal Selection: Fetch Results

<div class="flex justify-center">
  <img src="/images/slide_17.png" class="h-96" />
</div>

<!--
Fetch environment comparison of final, future, and episode HER strategies.
All three reach 1.0 success rate by ~600k steps.
Episode strategy (green) shows fastest initial convergence.
-->

---

# Mean Reward Comparison

<div class="flex justify-center">
  <img src="/images/slide_18.png" class="h-96" />
</div>

<!--
Table I: Mean reward ± std for TD3, TD3+HER Final, and TD3+HER+Future across all 6 tasks.
FetchReach: best across all methods.
Hand manipulation tasks show much larger negative rewards.
-->

---

# Conclusion

<v-clicks>

- We benchmark two policy gradient methods on two different multi-goal environments across six tasks
- First work to benchmark different goal selection strategies for HER in complex hand manipulation environments
- HER with episodic goal selection strategy can significantly improve sample efficiency and learning speed
- Combined with TD3, the model learns to operate in challenging scenarios
- **Future work:** test our method on a real robot

</v-clicks>

---

# References

<div class="text-xs leading-relaxed space-y-2">

- Andrychowicz et al., "Hindsight experience replay," NeurIPS, vol. 30, 2017
- David Silver, UCL Course on Reinforcement Learning, 2015
- Raffin et al., "Stable-Baselines3: Reliable RL implementations," JMLR, vol. 22, 2021
- Sutton & Barto, *Reinforcement Learning: An Introduction*, MIT Press, 2nd ed., 2018
- Mnih et al., "Playing Atari with deep reinforcement learning," CoRR, 2013
- Lillicrap et al., "Continuous control with deep reinforcement learning," CoRR, 2016

</div>
