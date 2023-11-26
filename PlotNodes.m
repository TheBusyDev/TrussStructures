function PlotNodes (nodes_pos, nodes_con, N_n)
    hold on; grid on; axis equal

    % plot nodes
    for i = 1:N_n
        % node is fully constrained
        if nodes_con(i,1) == 1 && nodes_con(i,2) == 1 
            color = [1 0 0];

        % node is not constrained
        elseif nodes_con(i,1) == 0 && nodes_con(i,2) == 0
            color = [0 1 0];
        
        % node is partially constrained
        else 
            color = [1 0.5 0];
        end

        plot (nodes_pos(i,1), nodes_pos(i,2), 'o', 'Color', color, 'LineWidth', 1.2)
    end
end