filekey='random-regular000*.mat';

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

figure(1)
plot(popdatacoop,'b');
hold
plot(popdatadef,'r');
hold off

figure(2)
plot(agedatacoop,'b');
hold
plot(agedatadef,'r');
hold off