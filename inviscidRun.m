%function [ output_args ] = Untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n = 100;
max_epoch = 100;

gameYoung = [ 0.3,0;
              0.3, 0];

gameOld = [ -2, 0;
            -2, 0];
        
adjmx = ones(n);
w = 0.01/(2*n);


strats = randi(2,n,1);
mat_ages = randi(10,n,1);
genotypes = [strats,mat_ages];

pmod = .1;
pmut = [1, 1];

reproduce = @(agent) indMutReproduce(agent, pmut);

updateRule = @deathBirth;



data = pig(adjmx,genotypes,zeros(n),zeros(n),gameYoung,gameOld, w, updateRule, max_epoch,pmod,reproduce);













%end

