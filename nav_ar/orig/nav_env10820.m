classdef nav_env < rl.env.MATLABEnvironment
    %MYENV: Template for defining custom environment in MATLAB.
    
    %% Properties (set properties' attributes accordingly)
    properties
        % Specify and initialize environment's necessary properties
        % environment features, description of food location and cue
        % distributions
        env_feat = struct;
        
        % environmental parameters
        env_param = struct;
        
        % initial agent location
        iniloc = zeros(1,2);
        
        % number of decrements for heading angle
        actnum = 4;
        
        % Reward vector, including rewards, incentives, and costs
        rwds = struct;
                
        % naviagtion log
        Logsig = struct;

    end
    
    properties
        % Initialize system state [x,dx,theta,dtheta]'
        State = zeros(2,4)
        
        Figure
    end
    
    properties(Access = protected)
        % Initialize internal flag to indicate episode termination
        IsDone = false

    end
    
    %% Necessary Methods
    methods
        % Contructor method creates an instance of the environment
        % Change class name and constructor name accordingly
        function this = nav_env()
            % Initialize observation settings
            obsInfo = rlNumericSpec([1 8]);
            obsInfo.Name = 'diffusive cues';
            obsInfo.Description = 'cue1, cue2, cue3, cue4';
            
            % Initialize action settings
            % discretize movement direction
            dstp = 2*pi/4;
            actInfo = rlFiniteSetSpec(0:dstp:((2*pi)-dstp));
            actInfo.Name = 'discretized movement angle (radian)';
            
            % The following line implements built-in functions of RL env
            this = this@rl.env.MATLABEnvironment(obsInfo,actInfo);
            
            % Initialize property values and pre-compute necessary values
            updateActionInfo(this);
        end
        
        % Apply system dynamics and simulates the environment with the
        % given action for one step.
        function [nextobs,rwd,dnflg,logsig] = step(this,act)
            % Execute movement
            logsig = this.Logsig; envfeat = this.env_feat;
            cpm = this.env_param;
            loc_c = logsig.loc_h(end,:) + cpm.spd*[cos(act) sin(act)];
            % enforce boundary conditions
            xbd = envfeat.crdx([1 end]);
            ybd = envfeat.crdy([1 end]);
            loc_c(1) = min(xbd(2),(max(xbd(1),loc_c(1))));
            loc_c(2) = min(ybd(2),(max(ybd(1),loc_c(2))));
            
            % Querie cue values
            cc_st = nan(1,cpm.cn);
            for ti = 1:cpm.cn
                cc_st(ti) = envfeat.c(ti).mp(round(loc_c(2)-cpm.ysft),...
                    round(loc_c(1)-cpm.xsft));
            end
            % Update state log
            logsig.cc_st = cc_st;
            logsig.cc_h = [logsig.cc_h;(cc_st(:))'];
            logsig.loc_c = loc_c;
            logsig.loc_h = [logsig.loc_h;(loc_c(:))'];
            logsig.act_h = [logsig.act_h;act];
            this.Logsig = logsig;
                                 
            % Update system states
            this.State = logsig.cc_h((end-1):end,:);
            
            % Assign state value to next observation.
            nextobs = this.State;
            
            % Check terminal condition.
            dnflg = nav_checkstop(loc_c-[cpm.xsft cpm.ysft],envfeat);
            this.IsDone = dnflg;
            
            % Get reward
            rwd = getReward(this);
            
            % (optional) use notifyEnvUpdated to signal that the
            % environment has been updated (e.g. to update visualization)
            notifyEnvUpdated(this);
        end
        
        % Reset environment to initial state and output initial observation
        function [iniobs, logsig] = reset(this)
            envfeat = this.env_feat;
            cpm = this.env_param;
            loc0 = [(rand-.5)*cpm.xrn/2 (rand-.5)*cpm.yrn/2];%this.iniloc;
%             loc0 = [-530 57]+300*(rand(1,2)-.5); % fix starting location to a region
            this.iniloc = loc0;
            % Reset agent initial location and query corresponding cue values.
            cc_st = nan(1,cpm.cn);
            for ti = 1:cpm.cn
                cc_st(ti) = envfeat.c(ti).mp(round(loc0(2)-cpm.ysft),...
                    round(loc0(1)-cpm.xsft));
            end
            
            % Return initial environment state variables as logged signals.
            logsig.cc_st = cc_st;
            logsig.cc_h = cc_st;
            logsig.loc_c = loc0;
            logsig.loc_h = loc0;
            % logsig.act_c = nan;
            logsig.act_h = nan;
            
            this.Logsig = logsig;
            this.State = [(cc_st(:))';(cc_st(:))'];
            
            iniobs = this.State;
            
            % (optional) use notifyEnvUpdated to signal that the
            % environment has been updated (e.g. to update visualization)
            notifyEnvUpdated(this);
        end
    end
    %% Optional Methods (set methods' attributes accordingly)
    methods
        % Helper methods to create the environment
        % update the action info based on max force
        function updateActionInfo(this)
            dstp = 2*pi/this.actnum;
            this.ActionInfo.Elements = (0:dstp:((2*pi)-dstp));
        end
        
        % Reward function
        function Reward = getReward(this)
            if ~this.IsDone
                Reward = this.rwds.cost; % cost for moving
            else
                Reward = this.rwds.r(1);
            end
        end
        
        % (optional) Visualization method
        function plot(this)
            % Initiate the visualization
            this.Figure = figure('Visible','on','HandleVisibility','off');
%             ha = gca(this.Figure); hold(ha,'on');
    
            % Update the visualization
            envUpdatedCallback(this)
        end
        
        % (optional) Properties validation through set methods
        function set.env_feat(this,envfeat)
%             validateattributes(envfeat,{'numeric'},{'finite','real','struct'},'','env_feat');
            this.env_feat = envfeat;
            notifyEnvUpdated(this);
        end
        
        function set.env_param(this,cpm)
            this.env_param = cpm;
            notifyEnvUpdated(this);
        end
        
        function set.actnum(this,actn)
            this.actnum = actn;
            notifyEnvUpdated(this);
        end
        
        function set.iniloc(this,loc0)
            this.iniloc = loc0;
            notifyEnvUpdated(this);
        end
        
        function set.State(this,state)
%             validateattributes(state,{'numeric'},{'finite','real','vector','numel',4},'','State');
            this.State = (state(:))';
            notifyEnvUpdated(this);
        end
        
        function set.rwds(this,rwstrct)
%             validateattributes(val,{'numeric'},{'real','finite','scalar'},'','Reward/Incentive/Cost');
            this.rwds = rwstrct;
        end

    end
    
    methods (Access = protected)
        % (optional) update visualization everytime the environment is updated
        % (notifyEnvUpdated is called)
        function envUpdatedCallback(this)
            env_update
        end
    end
end
