

function data = pig (adjmx, genotypes, ages, base_fitnesses, gameYoung,gameOld, w, updateRule, max_epoch,pmod,reproduce)
% function pig (adjmx, agents, game, w, update_rule, max_epoch)
%   agents is a n by 5 matrix where each row is an agent and for each
%   agent, the first entry is strategy, second is maturation age, third is
%   age, fourth is size, fifth is fitness
%   game - is the square game matrix
%   age, fourth is size
%   adjmx - N x N boolean matrix describing connectivity
%   w  - selection strength
%   update_rule is a function (adjmx,agents,w, fitness --> agents) that
%   specifies how agents are modified.
%   max_epoch - number of iterations of the simulation
%   pmod - percent modified in the update rule


max_mat_age = 100;
data = zeros( max_mat_age,length(gameYoung), max_epoch);

for epoch = 1:max_epoch
    [base_fitnesses, fitnesses] = getFit(adjmx, genotypes, ages, base_fitnesses, gameYoung, gameOld);
    [genotypes ages base_fitnesses] = updateRule(adjmx, genotypes, ages, base_fitnesses, w, fitnesses, pmod, reproduce);
    data(:,:,epoch) = getData(genotypes,length(gameYoung));
    ages = ages + 1; %ages
end
    
    


