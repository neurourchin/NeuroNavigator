classdef nav_environ < rl.env.MATLABEnvironment
    
    properties
        % Initialize system state [x,dx,theta,dtheta]'
        StepFcn = @(act,logsig)nav_step(act,logsig);
        ResetFcn = @(act,logsig) nav_step(act,logsig);
    end
    
    properties(Access = protected)
        % Initialize internal flag to indicate episode termination
        IsDone = false
        
        % Handle to figure
        Figure
    end
    
end