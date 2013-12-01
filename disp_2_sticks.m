function [ output_args ] = disp_stick(start_state1, start_state2, lens)
%DISP_2_STICKS Summary of this function goes here
%   Detailed explanation goes here

base = [0,0]; % assume base at the origin

rt_foot1 = base + [-lens(1)*sin(start_state1(1)/2), -lens(1)*cos(start_state1(1)/2)];
lt_foot1 = base + [lens(1)*sin(start_state1(1)/2), -lens(1)*cos(start_state1(1)/2)];

torso1 = base + [-lens(4)*sin(start_state1(2)), lens(4)*cos(start_state1(2))];

head1 = torso1 + [-lens(5)*sin(start_state1(3)), lens(5)*cos(start_state1(3))];

rt_shoulder1 = torso1 + [-lens(6), 0];
lt_shoulder1 = torso1 + [lens(6), 0];

rt_elbow1 = rt_shoulder1 + [-lens(3)*sin(start_state1(4)), lens(3)*cos(start_state1(4))];
lt_elbow1 = lt_shoulder1 + [-lens(3)*sin(start_state1(6)), lens(3)*cos(start_state1(6))];

rt_wrist1 = rt_elbow1 + [-lens(2)*sin(start_state1(5)), lens(2)*cos(start_state1(5))];
lt_wrist1 = lt_elbow1 + [-lens(2)*sin(start_state1(7)), lens(2)*cos(start_state1(7))];


rt_foot2 = base + [-lens(1)*sin(start_state2(1)/2), -lens(1)*cos(start_state2(1)/2)];
lt_foot2 = base + [lens(1)*sin(start_state2(1)/2), -lens(1)*cos(start_state2(1)/2)];

torso2 = base + [-lens(4)*sin(start_state2(2)), lens(4)*cos(start_state2(2))];

head2 = torso2 + [-lens(5)*sin(start_state2(3)), lens(5)*cos(start_state2(3))];

rt_shoulder2 = torso2 + [-lens(6), 0];
lt_shoulder2 = torso2 + [lens(6), 0];

rt_elbow2 = rt_shoulder2 + [-lens(3)*sin(start_state2(4)), lens(3)*cos(start_state2(4))];
lt_elbow2 = lt_shoulder2 + [-lens(3)*sin(start_state2(6)), lens(3)*cos(start_state2(6))];

rt_wrist2 = rt_elbow2 + [-lens(2)*sin(start_state2(5)), lens(2)*cos(start_state2(5))];
lt_wrist2 = lt_elbow2 + [-lens(2)*sin(start_state2(7)), lens(2)*cos(start_state2(7))];



clf

subplot(1,2,1)
xlim([-2.5 2.5])
ylim([-2.5 2.5])

% draw joints
% scatter([base(1); rt_foot(1);lt_foot(1); torso(1); head(1); rt_elbow(1); lt_elbow(1); rt_wrist(1); lt_wrist(1); rt_shoulder(1); lt_shoulder(1)],...
%     [base(2); rt_foot(2);lt_foot(2); torso(2); head(2); rt_elbow(2); lt_elbow(2); rt_wrist(2); lt_wrist(2); rt_shoulder(2); lt_shoulder(2)], 15, 'filled')

hold on

% connect joints
line([[base(1); rt_foot1(1)],[base(1);lt_foot1(1)], [base(1);torso1(1)], [torso1(1);head1(1)], [rt_shoulder1(1);rt_elbow1(1)], [lt_shoulder1(1);lt_elbow1(1)]...
    ,[rt_elbow1(1);rt_wrist1(1)], [lt_elbow1(1);lt_wrist1(1)], [torso1(1);rt_shoulder1(1)], [torso1(1);lt_shoulder1(1)]],...
    [[base(2); rt_foot1(2)],[base(2);lt_foot1(2)], [base(2);torso1(2)], [torso1(2);head1(2)], [rt_shoulder1(2);rt_elbow1(2)], [lt_shoulder1(2);lt_elbow1(2)]...
    ,[rt_elbow1(2);rt_wrist1(2)], [lt_elbow1(2);lt_wrist1(2)], [torso1(2);rt_shoulder1(2)], [torso1(2);lt_shoulder1(2)]])


subplot(1,2,2)
xlim([-2.5 2.5])
ylim([-2.5 2.5])

% draw joints
% scatter([base(1); rt_foot(1);lt_foot(1); torso(1); head(1); rt_elbow(1); lt_elbow(1); rt_wrist(1); lt_wrist(1); rt_shoulder(1); lt_shoulder(1)],...
%     [base(2); rt_foot(2);lt_foot(2); torso(2); head(2); rt_elbow(2); lt_elbow(2); rt_wrist(2); lt_wrist(2); rt_shoulder(2); lt_shoulder(2)], 15, 'filled')

hold on

% connect joints
line([[base(1); rt_foot2(1)],[base(1);lt_foot2(1)], [base(1);torso2(1)], [torso2(1);head2(1)], [rt_shoulder2(1);rt_elbow2(1)], [lt_shoulder2(1);lt_elbow2(1)]...
    ,[rt_elbow2(1);rt_wrist2(1)], [lt_elbow2(1);lt_wrist2(1)], [torso2(1);rt_shoulder2(1)], [torso2(1);lt_shoulder2(1)]],...
    [[base(2); rt_foot2(2)],[base(2);lt_foot2(2)], [base(2);torso2(2)], [torso2(2);head2(2)], [rt_shoulder2(2);rt_elbow2(2)], [lt_shoulder2(2);lt_elbow2(2)]...
    ,[rt_elbow2(2);rt_wrist2(2)], [lt_elbow2(2);lt_wrist2(2)], [torso2(2);rt_shoulder2(2)], [torso2(2);lt_shoulder2(2)]])



end

