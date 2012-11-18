function [genotypesNew ages base_fitnesses fitnesses] = deathBirth( adjmx, ...
    genotypesOld, w, fitnesses, pmod, reproduce)
%deathBirth Summary of this function goes here
%   Detailed explanation goes here
%   reproduce is a function

genotypesNew = genotypesOld;

r = randperm(length(genotypes));
n_killed = floor(length(genotypes)*pmod);
dead = r(1:n_killed);
num_list = 1:length(genotypes);

for i = 1:n_killed
    
    neighbours_indices = num_list(adjmx(dead(i),:)==1);
    neighbours_fitnesses=fitnesses(neighbours_indices);
    neighbours_cdf = cumsum(fit2pdf(neighbours_fitnesses,w));
    choices = neighbours_indices(neighbours_cdf > rand);
    genotypesNew(dead(i)) = reproduce(genotypesOld(choices(1)));
end


    
