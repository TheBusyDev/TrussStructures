function PlotForce (nodes_pos, force, N_n)
    hold on; grid on; axis equal

    max_force = max (max (abs(force)));
    max_f = max (max (abs(nodes_pos))) / 3; % needed to scale force when plotting

    % plot forces
    for i = 1:N_n
        if force(i,1) ~= 0
            f = force(i,1)/max_force * max_f; % scaled force intensity
            quiver (nodes_pos(i,1), nodes_pos(i,2), f, 0, 'Color', 'm', 'LineWidth', 1.2)
        end

        if force(i,2) ~= 0
            f = force(i,2)/max_force * max_f; % scaled force intensity
            quiver (nodes_pos(i,1), nodes_pos(i,2), 0, f, 'Color', 'm', 'LineWidth', 1.2)
        end
    end
end