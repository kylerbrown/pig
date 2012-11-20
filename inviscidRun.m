%function [ output_args ] = Untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n = 400;
max_epoch = 2000;

gameYoung = [ .4, 0;
              .4, 0];

gameOld = [ -1, -1;
            0, 0];
        
adjmx = ones(n);
w = .001;


strats = ceil(2*(0.7*rand(n,1) + 0.3));
mat_ages = randi(10,n,1);
genotypes = [strats,mat_ages];

pmod = .1;
pmut = [.001, .05];

reproduce = @(agent) indMutReproduce(agent, pmut);

updateRule = @deathBirth;


tic
data = pig(adjmx,genotypes,zeros(n,1),zeros(n,1),gameYoung,gameOld, w, updateRule, max_epoch,pmod,reproduce);
toc
%%
figure(1)
hold
plot(squeeze(sum(data(:,1,:),1))','b.');
plot(squeeze(sum(data(:,2,:),1))','r.');

figure(2)
plot((1:size(data,1))*squeeze(data(:,1,:))./max(sum(squeeze(data(:,1,:))),1) ,'c.');
hold
plot((1:size(data,1))*squeeze(data(:,2,:))./max(sum(squeeze(data(:,2,:))),1) ,'m.');









%end

