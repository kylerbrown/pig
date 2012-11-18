function [ genotypes ] = indMutReproduce( genotypes, pmut )
%indMutReproduce 
%   Detailed explanation goes here
% genotypes, rows are agents, collumns are genes
% first gene is strat, second is mat_age
% PMUT - probablility of mutation, is a vector
% nstrats is the number of strats for the first gene

%mutate strat
mutstrats=rand(length(genotypes),1) < repmat(pmut(1),length(genotypes),1);
genotypes(mustrats,1)=randi(2,sum(mutstrats),1);

%mutate age
mutage=rand(length(genotypes),1) < repmat(pmut(2),length(genotypes),1);
genotypes(mutage,2)=genotypes(mutage,2) + (randi(2,sum(mutage),1)-1)*2-1;
genotypes(genotypes(:,2) < 0,2) = 0;