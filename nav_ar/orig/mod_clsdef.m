classdef nav_world < rl.env.MATLABEnvironment
    properties
        % Specify and initialize the necessary properties of the environment
        % Acceleration due to gravity in m/s^2
        Gravity = 9.8
        
        % Mass of the cart
        CartMass = 1.0
        
        % Mass of the pole
        PoleMass = 0.1
        
        % Half the length of the pole
        HalfPoleLength = 0.5
        
        % Max force the input can apply
        MaxForce = 10
        
        % Sample time
        Ts = 0.02
        
        % Angle at which to fail the episode (radians)
        AngleThreshold = 12 * pi/180
        
        % Distance at which to fail the episode
        DisplacementThreshold = 2.4
        
        % Reward each time step the cart-pole is balanced
        RewardForNotFalling = 1
        
        % Penalty when the cart-pole fails to balance
        PenaltyForFalling = -10
    end
    
    properties
        % Initialize system state [x,dx,theta,dtheta]'
        State = zeros(4,1)
    end
    
    properties(Access = protected)
        % Initialize internal flag to indicate episode termination
        IsDone = false
        
        % Handle to figure
        Figure
    end
end