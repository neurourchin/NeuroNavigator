This repo contains two directories:

1.nav_nn\: agent learns to navigate a multisensory 2D arena using a bio-inspired neural network with reward-dependent hebbian plasticity
2.nav_ar\: agent learns to navigate using standard RL algorithm, e.g. DQN, REINFORCE.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Key scripts under each directory:

Under nav_nn\:
NavMaster_lr2b.m: initializes, trains and tests a bio-inspired network to drive navigation (practically identical to NavMaster_lr2.m, only differ in output plots)

env_generate_nn.m: allows user to load an existing set of environmental params or create a new set

agent_generate_lr.m: initializes the bio-inspired network, the memory buffer of the agent, and the training history

run_nav_update_lr.m: executes one training epochs. During each epoch, the agent navigates for a finite # of steps in the 2D environment.

learn_update.m: updates network weights based on whether the agent reached a food patch (i.e. gained the reward). Currently, only input weights to the multual inhibition loop are plastic. Edges that were active just prior to arrival at a food patch are strengthened. If no food patch was reached, the weights are brought close to a uniform values.

ea_visualizer.m: visualize the agent's most recent navigation trajectory and the internal dynamics of the neural network (speciacally the two nodes of the mutual inhibitory loop).

Nav_train_cmp.m: loads and plots the training history of both the bio-inspired algorithm and standard RL algorithms

-------------------------------------------
Under nav_ar\:

NavMaster_ar_lr.m: initializes, trains and tests agents to navigation using agents driven by standard RL algorithms. The agent has two action choices: explore (roam) or exploit (dwell). Roaming is simplified as picking a random starting direction and keep going in that direction.


NavMaster_arrw_lr.m: differ from NavMaster_ar_lr.m only in that agent's action choices are defined as: exploit, explore-up, explore-down, explore-left, explore-right. Can modify to increase the number of discrete heading directions.

env_generate_ar.m: generate a multisensory 2D environment in format compatible with RL training commands in MATLAB.

agent_generate_ar.m: initialize the RL agent.

trainRLagent: specify training params and performs training.

