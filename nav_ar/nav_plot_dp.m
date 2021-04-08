function nav_plot(this)
    % Initiate the visualization
    this.Figure = figure('Visible','on','HandleVisibility','off');
    ha = gca(this.Figure);
% %     ha.XLimMode = 'manual';
% %     ha.YLimMode = 'manual';
% %     ha.XLim = [-3 3];
% %     ha.YLim = [-1 2];
    hold(ha,'on');
    % Update the visualization
    navUpdatedCallback(this)
end