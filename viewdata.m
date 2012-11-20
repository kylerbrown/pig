filekey='random-regular010*.mat';

%runthrough and remove corrupted data
files = dir(filekey);
for ithfile=1:numel(files)
    try
        load(files(ithfile).name);
    catch err
    files(ithfile).name    
    disp(err.message)
    delete(files(ithfile).name);
    disp('deleted')
    end
end

%%
files = dir(filekey);
load(files(1).name);
popdatacoop=zeros(max_epoch,numel(files));
popdatadef=zeros(max_epoch,numel(files));

agedatacoop=zeros(max_epoch,numel(files));
agedatadef=zeros(max_epoch,numel(files));
for ithfile=1:numel(files)
    files(ithfile).name
    load(files(ithfile).name);
    popdatacoop(:,ithfile)=squeeze(sum(data(:,1,:),1));
    popdatadef(:,ithfile)=squeeze(sum(data(:,2,:),1));
    agedatacoop(:,ithfile)=(1:size(data,1))*squeeze(data(:,1,:))./max(sum(squeeze(data(:,1,:))),1);
    agedatadef(:,ithfile)=(1:size(data,1))*squeeze(data(:,2,:))./max(sum(squeeze(data(:,2,:))),1);
end

%%

f1 = figure(1)
plot(popdatacoop,'b');
hold
plot(popdatadef,'r');
plot(mean(popdatacoop,2),'c',...
                'LineWidth',4)
            plot(mean(popdatadef,2),'m',...
                'LineWidth',4)
hold off
title('B/C = 1')
ylabel('# agents')
xlabel('cycle')
print(f1,'-dtiff','BC10_pop')
%
f2 = figure(2)
plot(agedatacoop,'b');
hold
plot(agedatadef,'r');
plot(mean(agedatacoop,2),'c',...
                'LineWidth',4)
            plot(mean(agedatadef,2),'m',...
                'LineWidth',4)
hold off

title('B/C = 1')
ylabel('maturation age')
xlabel('cycle')
print(f2,'-dtiff','BC10_age')