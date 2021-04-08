function envUpdatedCallback(this)
    if ~isempty(this.Figure) && isvalid(this.Figure)
        env_feat = this.env_feat;
%             cpm = this.env_param; loc0 = this.iniloc;
            

        % Set visualization figure as the current figure
        ha = gca(this.Figure);
        
        % plot navigation environment
        imshow(env_feat.c(1).mp);colormap parula
        plot(env_feat.f(1).bds(:,1),env_feat.f(1).bds(:,2),...
            'm','linewidth',1.5)

        
        % Query agent trajecotry
        locxy = this.Logsig.loc_h;

        trjplot = findobj(ha,'Tag','trjtplot');
        frntplot = findobj(ha,'Tag','frntplot');
        if isempty(trjplot) || ~isvalid(trjplot)...
               || isempty(frntplot) || ~isvalid(frntplot)
            % Initialize the trajectory plot
            trjplot = plot(locxy(:,1),locxy(:,2),'color','w','linewidth',1.5);
            trjplot.Tag = 'trjplot';
            frntplot = plot(locxy(1,1),locxy(1,2),'ro','linewidth',1.5,'markerfacecolor','r');
            frntplot.Tag = 'frntplot';
        else
            trjplot.XData = locxy(:,1);
            trjplot.YData = locxy(:,2);
            frntplot.XData = locxy(end,1);
            frntplot.YData = locxy(end,2);
        end

        % Refresh rendering in the figure window
        drawnow();
    end
end