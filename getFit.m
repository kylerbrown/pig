function [base_fitnesses, fitnesses] = getFit(adjmx, genotypes, ages, base_fitnesses, gameYoung, gameOld)
%gitFit updates fitness of agents
%   Detailed explanation goes here
fitnesses = zeros(length(base_fitnesses),1);
for i = 1:length(genotypes)
    for j=i:length(genotypes)
        if adjmx(i,j)
            if (genotypes(i,2) < ages(i) && genotypes(j,2) >= ages(j))
               base_fitnesses(i) = base_fitnesses(i) + gameYoung(genotypes(i,1),genotypes(j,1));
               fitnesses(j) = fitnesses(j) + gameOld(genotypes(j,1), genotypes(i,1));
            elseif genotypes(i,2) >= ages(i) && genotypes(j,2) < ages(j)
               base_fitnesses(j) = base_fitnesses(j) + gameYoung(genotypes(j,1),genotypes(i,1));
               fitnesses(i) = fitnesses(i) + gameOld(genotypes(i,1), genotypes(j,1));
            end
        end
    end
end

