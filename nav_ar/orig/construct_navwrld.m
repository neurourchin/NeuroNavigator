function this = construct_navwrld(mpr)
    % Initialize observation settings
    ObservationInfo = rlNumericSpec([4 1]);
    ObservationInfo.Name = 'diffusive cues';
    ObservationInfo.Description = 'cue1, cue2, cue3, cue4';

    % Initialize action settings   
    ActionInfo = rlFiniteSetSpec([mpr.spd 0]);
    ActionInfo.Name = 'Explore vs exploit';

    % The following line implements built-in functions of the RL environment
    this = this@rl.env.MATLABEnvironment(ObservationInfo,ActionInfo);

    % Initialize property values and precompute necessary values
    updateActionInfo(this);
    
end