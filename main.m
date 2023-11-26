clc; clear; close all

%% WARNING: PLOT IS AMPLIFIED TO UNDERLINE THE DEFORMATION
%%          --> PLOT DEFORMATION DOES NOT CORRESPOND TO ACTUAL DEFORMATION!!!

%% DATA
% nodes position [mm]
nodes_pos = [
    0 0
    1732 0
    866 500
    0 1000
];

% number of nodes
N_n = size (nodes_pos, 1);

% nodes connection (rods)
rods = [
    1 2
    2 3
    1 3
    3 4
];

% number of rods
N_r = size (rods, 1);

% rods properties [MPa * mm^2]
E = 72e3;   % Young's modulus [MPa]
A = 1600;   % cross section area [mm^2]

rods_EA = E*A*ones (N_r, 1);

% nodes constraints (1 = direction constrained, 0 = not constrained)
nodes_con = [
    1 1
    0 0
    1 0
    1 1
];

% force acting on each node [N]
f = [
    0 0
    0 -1e4
    0 0
    0 0
];

% scaling factor to plot deformation
scale = 100;


%% PLOT STRUCTURE
PlotNodes(nodes_pos, nodes_con, N_n)
PlotRods (nodes_pos, rods, N_r, '-')
PlotForce(nodes_pos, f, N_n)


%% GENERATE STIFFNESS MATRIX (K)
% initialize
K = zeros (2*N_n, 2*N_n);

% rods contribution to stiffness matrix
for k = 1:N_r
    node1 = rods (k,1);
    node2 = rods (k,2);

    pos1 = nodes_pos (node1, :);
    pos2 = nodes_pos (node2, :);
    EA = rods_EA (k);

    [K1, K2, K3, K4] = StiffnessMatrix (pos1, pos2, EA);

    i = [2*node1-1, 2*node1];
    j = [2*node2-1, 2*node2];

    K(i,i) = K(i,i) + K1;
    K(i,j) = K(i,j) + K2;
    K(j,i) = K(j,i) + K3;
    K(j,j) = K(j,j) + K4;
end

% remove lines related to constrained points
% find non-null elements in 'nodes_con', related to constrained points
j_constr = find (nodes_con');
K(j_constr,:) = []; % remove j-th lines
K(:,j_constr) = []; % remove j-th columns


%% GENERATE RIGHT-HAND SIDE (F)
F = f';
F = F(:);
F(j_constr) = []; % remove j-th lines


%% SOLVE LINEAR SYSTEM: K*U = F
U = K \ F;


%% PLOT DEFORMED STRUCTURE
% find null elements in 'nodes_con', related to free points
j_free = find (nodes_con == 0);

% nodes displacement
nodes_displ = zeros (N_n, 2);
nodes_displ(j_free) = U

% nodes final position
nodes_final_pos = nodes_pos + nodes_displ

PlotNodes(nodes_pos + scale*nodes_displ, nodes_con, N_n)
PlotRods (nodes_pos + scale*nodes_displ, rods, N_r, '-.')
