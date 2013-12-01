function [states] = gen_dynamics2(start_state, end_state, steps)

% simple linear interpolation
vec_direction = (end_state - start_state);

% non-linear using gaussian
iterg = normpdf(linspace(-1, 1, floor(steps/2)), 0, .25);
iterg = [iterg normpdf(linspace(-1, 1, steps-1 -floor(steps/2)), 0, .5)];
iterg(1:floor(steps/2)) = .5 * iterg(1:floor(steps/2))/sum(iterg(1:floor(steps/2)));
iterg(floor(steps/2)+1:end) = .5 * iterg(floor(steps/2)+1:end)/sum(iterg(floor(steps/2)+1:end));

% iterg = iterg/sum(iterg);

% non-linear using quadratic
iterq = (linspace(-1, 1, floor(steps/2))).^2;
iterq = [iterq normpdf(linspace(-1, 1, steps-1 -floor(steps/2)), 0, 1)];
iterq(1:floor(steps/2)) = .5 * iterq(1:floor(steps/2))/sum(iterq(1:floor(steps/2)));
iterq(floor(steps/2)+1:end) = .5 * iterq(floor(steps/2)+1:end)/sum(iterq(floor(steps/2)+1:end));

states = [start_state];

for i=1:numel(iterg)
    states = [states; states(end,:) + [0 0 0 iterg(i) iterq(i) iterg(i) iterq(i)].*vec_direction];
end

end