function Reward = nav_getReward(this)
    if ~this.IsDone
        Reward = this.RewardForNotFalling;
    else
        Reward = this.PenaltyForFalling;
    end          
end