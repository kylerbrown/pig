function [genotypes ages base_fitnesses fitnesses] = deathBirth( adjmx, ...
    genotypes, w, fitnesses, pmod, num_strat, mutation_strategy, mutation_mat_age )
%deathBirth Summary of this function goes here
%   Detailed explanation goes here
r = randperm(length(genotypes));
n_killed = floor(length(genotypes)/pmod);
dead = r(1:n_killed);

for i = 1:n_killed
    num_list = 1:length(genotypes);
    neighbours_indices = num_list(adjmx(dead(i),:)==1);
    neighbours_fitnesses=fitnesses(neighbours_indices);
    neighbours_pdf = (1 + w*neighbours_fitnesses)/(length(neighbours_indices) + w*sum(neighbours_fitnesses));
    neighbours_cdf = cumsum(neighbours_pdf);
    choices = neighbours_indices(neighbours_cdf > rand);
    choice(i) = choices(1);

end

for i = 1:n_killed,
    genotypes(dead(i)) = reproduce(genotypes(choice(i)),num_strat,mutation_strategy,mutation_mat_age) 
end
    
