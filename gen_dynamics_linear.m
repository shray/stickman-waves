function [states] = gen_dynamics_linear(start_state, end_state, steps)

% simple linear interpolation
vec_direction = (end_state - start_state);

states = [start_state];
iter = vec_direction./(steps-1);
for i=1:steps-1
    states = [states; states(end,:) + iter];
end

end