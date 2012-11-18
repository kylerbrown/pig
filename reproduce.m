function [ new_genotypes ] = indMutReproduce( genotypes, pmut )
%indMutReproduce 
%   Detailed explanation goes here
% genotypes, rows are agents, collumns are genes
% first gene is strat, second is mat_age
new_genotypes=genotypes;
mut=rand(size(genotypes)<

