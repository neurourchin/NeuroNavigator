function envUpdatedCallback_orig(this)
    if ~isempty(this.Figure) && isvalid(this.Figure)
        % Set visualization figure as the current figure
        ha = gca(this.Figure);

        % Extract the cart position and pole angle
        x = this.State(1);
        theta = this.State(3);

        cartplot = findobj(ha,'Tag','cartplot');
        poleplot = findobj(ha,'Tag','poleplot');
        if isempty(cartplot) || ~isvalid(cartplot) ...
                || isempty(poleplot) || ~isvalid(poleplot)
            % Initialize the cart plot
            cartpoly = polyshape([-0.25 -0.25 0.25 0.25],[-0.125 0.125 0.125 -0.125]);
            cartpoly = translate(cartpoly,[x 0]);
            cartplot = plot(ha,cartpoly,'FaceColor',[0.8500 0.3250 0.0980]);
            cartplot.Tag = 'cartplot';

            % Initialize the pole plot
            L = this.HalfPoleLength*2;
            polepoly = polyshape([-0.1 -0.1 0.1 0.1],[0 L L 0]);
            polepoly = translate(polepoly,[x,0]);
            polepoly = rotate(polepoly,rad2deg(theta),[x,0]);
            poleplot = plot(ha,polepoly,'FaceColor',[0 0.4470 0.7410]);
            poleplot.Tag = 'poleplot';
        else
            cartpoly = cartplot.Shape;
            polepoly = poleplot.Shape;
        end

        % Compute the new cart and pole position
        [cartposx,~] = centroid(cartpoly);
        [poleposx,poleposy] = centroid(polepoly);
        dx = x - cartposx;
        dtheta = theta - atan2(cartposx-poleposx,poleposy-0.25/2);
        cartpoly = translate(cartpoly,[dx,0]);
        polepoly = translate(polepoly,[dx,0]);
        polepoly = rotate(polepoly,rad2deg(dtheta),[x,0.25/2]);

        % Update the cart and pole positions on the plot
        cartplot.Shape = cartpoly;
        poleplot.Shape = polepoly;

        % Refresh rendering in the figure window
        drawnow();
    end
end