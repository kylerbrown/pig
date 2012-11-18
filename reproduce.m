function [ genotypes ] = indMutReproduce( genotypes, pmut )
%indMutReproduce 
%   Detailed explanation goes here
% genotypes, rows are agents, collumns are genes
% first gene is strat, second is mat_age
genotypes=genotypes;
mut=rand(size(genotypes)) < repmat(pmut,length(genotypes),1);
genotypes(:,1)

