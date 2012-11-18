function [genotypesNew, ages, base_fitnesses] = deathBirth( adjmx, ...
    genotypesOld, ages, base_fitnesses, w, fitnesses, pmod, reproduce)
%deathBirth Summary of this function goes here
%   Detailed explanation goes here
%   reproduce is a function
fitnesses=base_fitnesses+fitnesses;
genotypesNew = genotypesOld;


r = randperm(length(genotypesOld));
n_killed = floor(length(genotypesOld)*pmod);
dead = r(1:n_killed);
num_list = 1:length(genotypesOld);

matured_filter = (ages >= genotypesOld(:,2)); %the bits of matured agents

for i = 1:n_killed
    
    neighbours_indices = num_list((adjmx(dead(i),:)==1)&matured_filter');
    if ~isempty(neighbours_indices),
        neighbours_fitnesses=fitnesses(neighbours_indices);
        neighbours_cdf = cumsum(fit2pdf(neighbours_fitnesses,w));
        choices = neighbours_indices(neighbours_cdf > rand);
        if numel(choices) == 0
            1
        end
        genotypesNew(dead(i),:) = reproduce(genotypesOld(choices(1),:));
    else,
        genotypesNew(dead(i),:)=reproduce([]);
    end;
    ages(dead(i)) = 0;        
    base_fitnesses(dead(i)) = 0;
end


    
