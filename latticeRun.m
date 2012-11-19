%function [ output_args ] = Untitled( input_args )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

n = 512;
max_epoch = 50000;



gameOld = [ -1, -1;
            0, 0];
        

w = 1/4;

p_deffect = .5;
strats = (rand(n,1)<p_deffect)+1;
mat_ages = randi(10,n,1);
genotypes = [strats,mat_ages];

pmod = .05;
pmut = [.0001, .01];

reproduce = @(agent) indMutReproduce(agent, pmut);

updateRule = @deathBirth;

for i=0:10

gameYoung = [ i/10, 0;
              i/10, 0];
adjmx = adjList2Mx(makeGraph(n,'random_regular',4));
tic
data = pig(adjmx,genotypes,zeros(n,1),zeros(n,1),gameYoung,gameOld, w, updateRule, max_epoch,pmod,reproduce);
toc

datadir = '/home/2007/kbrown53/pigdata/';
dataname = 'random_regular';
data_files = dir([datadir,dataname,sprintf('%02d',i),'*']);
save_num = size(data_files,1)+1;
save([datadir,dataname,sprintf('%04d',save_num)]);
end
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

