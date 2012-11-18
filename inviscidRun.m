%function [ output_args ] = Untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n = 100;
max_epoch = 3000;

gameYoung = [ 0.,0;
              0., 0];

gameOld = [ -2, 0;
            -2, 0];
        
adjmx = ones(n);
w = [];


strats = randi(2,n,1);
mat_ages = randi(10,n,1);
genotypes = [strats,mat_ages];

pmod = .01;
pmut = [.00, .05];

reproduce = @(agent) indMutReproduce(agent, pmut);

updateRule = @deathBirth;


tic
data = pig(adjmx,genotypes,zeros(n,1),zeros(n,1),gameYoung,gameOld, w, updateRule, max_epoch,pmod,reproduce);
toc
figure;
hold;
plot(squeeze(sum(data(:,1,:),1))','b.');
plot(squeeze(sum(data(:,2,:),1))','r.');
hold;











%end

