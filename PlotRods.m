function PlotRods (nodes_pos, rods, N_r, line_style)
    hold on; grid on; axis equal

    % plot rods
    x_r = [];
    y_r = [];

    for k = 1:N_r
        x_r = [x_r; nodes_pos(rods(k,1), 1)];
        x_r = [x_r; nodes_pos(rods(k,2), 1)];

        y_r = [y_r; nodes_pos(rods(k,1), 2)];
        y_r = [y_r; nodes_pos(rods(k,2), 2)];
    end

    plot (x_r, y_r, [line_style, 'b'])
end