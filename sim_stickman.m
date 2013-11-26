%% Simulation

clear
close all

% Globals
rng(30,'twister');

VISUAL = 1; % display simulation

DEG_TO_RAD = 1 * (pi/360);

LEGS_LEN = 2;
FOREARM_LEN = .75;
BACKARM_LEN = .75;
LOWERTORSO_LEN = 1;
UPPERTORSO_LEN = 1;
SHOULDER_LEN = .1;

STICK_LENS  = [LEGS_LEN, FOREARM_LEN, BACKARM_LEN, LOWERTORSO_LEN, UPPERTORSO_LEN, SHOULDER_LEN];

% Start state with arms around the waist

%simplified - so only in 2D right now
start_state = [1/32*pi, 0, 0, pi, pi-.005, -pi, -pi+.005]; % angles [b/w legs, lower-torso, upper-torso, rt-backarm, rt-forearm, lt-backarm, lt-forearm]
end_state = [1/32*pi, 0, 0, 0+2*DEG_TO_RAD, 0-5*DEG_TO_RAD, -0-2*DEG_TO_RAD, -0+5*DEG_TO_RAD];

move_arms_up = gen_dynamics(start_state, end_state, 50);
move_arms_down = gen_dynamics(end_state, start_state, 50);

% Add gaussian noise
% move_arms_down = move_arms_down + .0001*randn(size(move_arms_down));
% move_arms_up = move_arms_up + .0001*randn(size(move_arms_up));

%% VISUAL
if VISUAL    
    figure    
    for i=1:size(move_arms_up,1)            
        disp_stick(move_arms_up(i,:), STICK_LENS)
        pause(.1)
    end

    for i=1:size(move_arms_down,1)
        disp_stick(move_arms_down(i,:), STICK_LENS)
        pause(.1)
    end
end


% concatenate - data
data_vec = [move_arms_up; move_arms_down];

% do pca
[coeff,score,latent] = princomp(data_vec);

plot_2d_pca
plot_3d_pca