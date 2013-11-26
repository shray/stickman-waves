function [  ] = disp_stick(start_state, lens)
%BRIEF - Displays 2D stick man given her state
% lens = [LEGS_LEN, FOREARM_LEN, BACKARM_LEN, LOWERTORSO_LEN, UPPERTORSO_LEN, SHOULDER_LEN]
% state = angles [b/w legs, lower-torso, upper-torso, rt-backarm, rt-forearm, lt-backarm, lt-forearm]

base = [0,0]; % assume base at the origin

rt_foot = base + [-lens(1)*sin(start_state(1)/2), -lens(1)*cos(start_state(1)/2)];
lt_foot = base + [lens(1)*sin(start_state(1)/2), -lens(1)*cos(start_state(1)/2)];

torso = base + [-lens(4)*sin(start_state(2)), lens(4)*cos(start_state(2))];

head = torso + [-lens(5)*sin(start_state(3)), lens(5)*cos(start_state(3))];

rt_shoulder = torso + [-lens(6), 0];
lt_shoulder = torso + [lens(6), 0];

rt_elbow = rt_shoulder + [-lens(3)*sin(start_state(4)), lens(3)*cos(start_state(4))];
lt_elbow = lt_shoulder + [-lens(3)*sin(start_state(6)), lens(3)*cos(start_state(6))];

rt_wrist = rt_elbow + [-lens(2)*sin(start_state(5)), lens(2)*cos(start_state(5))];
lt_wrist = lt_elbow + [-lens(2)*sin(start_state(7)), lens(2)*cos(start_state(7))];

clf
xlim([-2.5 2.5])
ylim([-2.5 2.5])

% draw joints
% scatter([base(1); rt_foot(1);lt_foot(1); torso(1); head(1); rt_elbow(1); lt_elbow(1); rt_wrist(1); lt_wrist(1); rt_shoulder(1); lt_shoulder(1)],...
%     [base(2); rt_foot(2);lt_foot(2); torso(2); head(2); rt_elbow(2); lt_elbow(2); rt_wrist(2); lt_wrist(2); rt_shoulder(2); lt_shoulder(2)], 15, 'filled')

hold on

% connect joints
line([[base(1); rt_foot(1)],[base(1);lt_foot(1)], [base(1);torso(1)], [torso(1);head(1)], [rt_shoulder(1);rt_elbow(1)], [lt_shoulder(1);lt_elbow(1)]...
    ,[rt_elbow(1);rt_wrist(1)], [lt_elbow(1);lt_wrist(1)], [torso(1);rt_shoulder(1)], [torso(1);lt_shoulder(1)]],...
    [[base(2); rt_foot(2)],[base(2);lt_foot(2)], [base(2);torso(2)], [torso(2);head(2)], [rt_shoulder(2);rt_elbow(2)], [lt_shoulder(2);lt_elbow(2)]...
    ,[rt_elbow(2);rt_wrist(2)], [lt_elbow(2);lt_wrist(2)], [torso(2);rt_shoulder(2)], [torso(2);lt_shoulder(2)]])


end

