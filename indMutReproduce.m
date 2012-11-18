function [ genotypes ] = indMutReproduce( genotypes, pmut )
%indMutReproduce 
%   Detailed explanation goes here
% genotypes, rows are agents, collumns are genes
% first gene is strat, second is mat_age
% PMUT - probablility of mutation, is a vector
% nstrats is the number of strats for the first gene

%mutate strat
mut_strats=rand(size(genotypes,1),1) < repmat(pmut(1),size(genotypes,1),1);
genotypes(mut_strats,1)=randi(2,sum(mut_strats),1);

%mutate age
mutage=rand(size(genotypes,1),1) < repmat(pmut(2),size(genotypes,1),1);
genotypes(mutage,2)=genotypes(mutage,2) + (randi(2,sum(mutage),1)-1)*2-1;
genotypes((genotypes(:,2) < 0),2) = 0;