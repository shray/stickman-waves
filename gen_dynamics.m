function [states] = gen_dynamics(start_state, end_state, steps)

% simple linear interpolation
vec_direction = (end_state - start_state);

% non-linear using gaussian
iterg = normpdf(linspace(-1, 1, floor(steps/2)), 0, .5);
iterg = [iterg normpdf(linspace(-1, 1, steps-1 -floor(steps/2)), 0, .25)];
iterg = iterg/sum(iterg);

% non-linear using quadratic
iterq = (linspace(-1, 1, steps-1)).^2;
iterq = iterq/sum(iterq);


states = [start_state];

for i=1:numel(iterg)
    states = [states; states(end,:) + [0 0 0 iterg(i) iterq(i) iterg(i) iterq(i)].*vec_direction];
end

end