%function [ output_args ] = Untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n = 10*10;
max_epoch = 100;

gameYoung = [ 0.28, 0;
              0.28, 0];

gameOld = [ -1, -1;
            0, 0];
        
adjmx = adjList2Mx(makeGraph(n,'random-regular',4));
w = .25;

p_deffect = .5;
strats = (rand(n,1)<p_deffect)+1;
mat_ages = ones(n,1);
genotypes = [strats,mat_ages];

pmod = .01;
pmut = [.01, .01];

reproduce = @(agent) indMutReproduce(agent, pmut);

updateRule = @deathBirth;


tic
data = pig(adjmx,genotypes,zeros(n,1),zeros(n,1),gameYoung,gameOld, w, updateRule, max_epoch,pmod,reproduce);
toc
%%
% figure(1)
% plot(squeeze(sum(data(:,1,:),1))','b.');
% hold
% plot(squeeze(sum(data(:,2,:),1))','r.');
% hold off
% 
% figure(2)
% plot((1:size(data,1))*squeeze(data(:,1,:))./max(sum(squeeze(data(:,1,:))),1) ,'c.');
% hold
% plot((1:size(data,1))*squeeze(data(:,2,:))./max(sum(squeeze(data(:,2,:))),1) ,'m.');
% hold off








%end

