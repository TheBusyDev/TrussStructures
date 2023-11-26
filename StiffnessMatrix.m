function [K1, K2, K3, K4] = StiffnessMatrix (pos1, pos2, EA)

    delta_x = pos2(1) - pos1(1);
    delta_y = pos2(2) - pos1(2);

    l = sqrt (delta_x^2 + delta_y^2); % rod length

    cos_alpha = delta_x / l;
    sin_alpha = delta_y / l;

    % rotation matrix
    rot_mat = [
        cos_alpha sin_alpha 0 0
        0 0 cos_alpha sin_alpha
    ];

    % stiffness matrix
    K = EA/l * [1, -1; -1, 1];
    % rotate stiffness matrix
    K = rot_mat' * K * rot_mat;

    K1 = K(1:2, 1:2);
    K2 = K(1:2, 3:4);
    K3 = K(3:4, 1:2);
    K4 = K(3:4, 3:4);
end