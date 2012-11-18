%function [ output_args ] = Untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n = 400;
max_epoch = 3000;

gameYoung = [ .4, 0;
              .4, 0];

gameOld = [ -1, -1;
            0, 0];
        
adjmx = adjList2Mx(makeGraph(n,'lattice',4));
w = .001;


strats = ceil(2*(1*rand(n,1) + 0));
mat_ages = randi(10,n,1);
genotypes = [strats,mat_ages];

pmod = .05;
pmut = [.001, .05];

reproduce = @(agent) indMutReproduce(agent, pmut);

updateRule = @deathBirth;


tic
data = pig(adjmx,genotypes,zeros(n,1),zeros(n,1),gameYoung,gameOld, w, updateRule, max_epoch,pmod,reproduce);
toc
%%
figure(1)
plot(squeeze(sum(data(:,1,:),1))','b.');
hold
plot(squeeze(sum(data(:,2,:),1))','r.');
hold off

figure(2)
plot((1:size(data,1))*squeeze(data(:,1,:))./max(sum(squeeze(data(:,1,:))),1) ,'c.');
hold
plot((1:size(data,1))*squeeze(data(:,2,:))./max(sum(squeeze(data(:,2,:))),1) ,'m.');
hold off








%end

