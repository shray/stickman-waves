%% Simulation

clear
close all

% Globals
rng(30,'twister');

VISUAL = 1; % display simulation
STORE_VIDEO = 1;

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
move_arms_down = move_arms_down + .01*randn(size(move_arms_down));
move_arms_up = move_arms_up + .01*randn(size(move_arms_up));

%% VISUAL
if VISUAL
    counter = 1;
    f = figure;    
    for i=1:size(move_arms_up,1)            
        disp_stick(move_arms_up(i,:), STICK_LENS)
%         name = sprintf('temp_im_files/im%05d',counter);
%         print(f, name, '-dpng')
        counter = counter +1;
        pause(.1)
    end

    for i=1:size(move_arms_down,1)
        disp_stick(move_arms_down(i,:), STICK_LENS)
%         name = sprintf('temp_im_files/im%05d',counter);
%         print(f, name, '-dpng')
        counter = counter +1;
        pause(.1)
    end
end

%create video
% system('cd temp_im_files')
% system(['/usr/local/bin/ffmpeg -i im%05d.png -y -r 10 -vb 15M -vcodec libx264 ', 'human_motion', '.mp4']);
% system('rm -rf im*');

% concatenate - data
data_vec = [move_arms_up; move_arms_down];

% do pca
[coeff,score,latent] = princomp(data_vec);

% pca 1D reconstruction
data_mean = repmat(mean(data_vec,1),size(data_vec,1),1);
centered_data = data_vec - data_mean;
X_pca = centered_data * coeff(:,1);
Y_pca = X_pca * coeff(:,1)' + data_mean;
reconstruction_error_pca = Y_pca - data_vec;

% store video
if STORE_VIDEO
    pca_vid = VideoWriter('pca_reconstruction_linear.mp4');
    pca_vid.FrameRate = 10;
    open(pca_vid);

    
    for i=1:size(centered_data,1)                
        disp_2_sticks(data_vec(i,:),Y_pca(i,:), STICK_LENS)
        frame = getframe;
        writeVideo(pca_vid, frame)
        pause(.1)
    end
    pca_vid.close();
    
end

figure, plot_pca(data_vec, coeff(:,1)) % 1D projection in Principal Component Subspace
figure, plot_pca( data_vec, coeff(:,1:2)) % 2D projection in Principal Component Subspace
figure, plot_pca( data_vec, coeff(:,1:3)) % 3D projection in Principal Component Subspace

% 1D GPDM
[X_gpdm, theta_1, thetad_1, w_1, K_1, invK_1] = gpdm_it(data_vec, 1);

% Compute GPLVM reconstruction
[Y_gplvm, ~] = gpRegress( K_1, X_gpdm, [theta_1(2) 1/theta_1(1) 1/theta_1(3)], centered_data, X_gpdm );
Y_gplvm = Y_gplvm + data_mean;
reconstruction_error_gplvm = Y_gplvm - data_vec;

if STORE_VIDEO
    gp_vid = VideoWriter('gp_reconstruction_linear.mp4');
    gp_vid.FrameRate = 10;
    open(gp_vid);

    
    for i=1:size(centered_data,1)                
        disp_2_sticks(data_vec(i,:),Y_gplvm(i,:), STICK_LENS)
        frame = getframe;
        writeVideo(gp_vid, frame)
        pause(.1)
    end
    gp_vid.close();
    
end


