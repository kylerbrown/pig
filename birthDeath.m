function [genotypesNew ages base_fitnesses fitnesses] = birthDeath( adjmx, ...
    genotypesOld, w, fitnesses, pmod, reproduce)
%BIRTHDEATH Summary of this function goes here
%   reproduce is a function

num_list = 1:length(genotypesOld);

genotypesNew = genotypesOld;

agents_cdf = cumsum(fun2pdf(fitness,w));

for i=1:floor(length(genotypesOld)*pmod),
    %select the first agent that passes the cdf threshold
    choices = neighbours_indices(agents_cdf > rand);
    parent = choices(1);
    
    %get the list of parent's neighbours
    neighbours_indices = num_list(adjmx(parent,:)==1);
    
    %pick a neighbour uniformly at random.
    child = neighbours_indices(ceil(rand*length(neighbours_indices)));
    
    genotypesNew(child) = reproduce(genotypesOld(parent));
end

