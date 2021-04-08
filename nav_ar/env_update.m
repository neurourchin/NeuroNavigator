if ~isempty(this.Figure) && isvalid(this.Figure)
    envfeat = this.env_feat;
    cpm = this.env_param;
    xsft = cpm.xsft; ysft = cpm.ysft;
    %     loc0 = this.iniloc;
    
    
    % Set visualization figure as the current figure
    ha = gca(this.Figure);
    
    % plot navigation environment
    imshow(envfeat.c(1).mp);colormap parula
    hold all
    plot(envfeat.f(1).bds(:,1),envfeat.f(1).bds(:,2),...
        'm.','linewidth',1.5)
    
    
    % Query agent trajecotry
    locxy = this.Logsig.loc_h;
    
    trjplot = findobj(ha,'Tag','trjtplot');
    frntplot = findobj(ha,'Tag','frntplot');
    if isempty(trjplot) || ~isvalid(trjplot)...
            || isempty(frntplot) || ~isvalid(frntplot)
        % Initialize the trajectory plot
        trjplot = plot(locxy(:,1)-xsft,locxy(:,2)-ysft,'color','w','linewidth',1.5);
        trjplot.Tag = 'trjplot';
        frntplot = plot(locxy(end,1)-xsft,locxy(end,2)-ysft,'ro','linewidth',1.5,'markerfacecolor','r');
        frntplot.Tag = 'frntplot';
    else
        trjplot.XData = locxy(:,1)-xsft;
        trjplot.YData = locxy(:,2)-ysft;
        frntplot.XData = locxy(end,1)-xsft;
        frntplot.YData = locxy(end,2)-ysft;
    end
    
    % Refresh rendering in the figure window
    %     drawnow();
    drawnow limitrate
end