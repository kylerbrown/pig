function [adjList]= makeGraph (n, type, degree)

switch type
    case 'lattice'
        switch degree
            case 3
                % hexagonal lattice
                adjList = cell(1,n);
                for i=1:n
                    %even nodes on even rows or odd nodes on odd rows
                    if mod(i-1,2) == mod(mod(floor((i-1)/sqrt(n)),sqrt(n)),2)
                        %left(west)
                        side=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n)),sqrt(n))*sqrt(n);
                    else
                        %right(east)
                        side=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n)),sqrt(n))*sqrt(n);
                    end
                    %up
                    top=mod(i-1,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                    %bottom
                    bottom=mod(i-1,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    adjList{i}=[side top bottom];
                end
                
            case 4
                adjList = cell(1,n);
                for i=1:n
                    eastern=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n)),sqrt(n))*sqrt(n);
                    western=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n)),sqrt(n))*sqrt(n);
                    northern=mod(i-1,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                    southern=mod(i-1,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    
                    adjList{i}=[eastern, western, northern, southern];
                end
            case 6
                % triangular lattice
                adjList = cell(1,n);
                for i=1:n
                    left=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n)),sqrt(n))*sqrt(n);
                    right=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n)),sqrt(n))*sqrt(n);
                    bottom=mod(i-1,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    top=mod(i-1,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                    %top and bottom depend on row
                    if mod(mod(floor((i-1)/sqrt(n)),sqrt(n)),2) == 0 %even
                        %ne
                        topAlt=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                        %se
                        bottomAlt=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    else
                        %nw
                        topAlt=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                        %sw
                        bottomAlt=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    end
                    adjList{i}=[left right top bottom topAlt bottomAlt];
                end
            case 8
                % Moore lattice
                adjList = cell(1,n);
                for i=1:n
                    ne=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                    nw=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                    se=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    sw=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    eastern=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n)),sqrt(n))*sqrt(n);
                    western=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n)),sqrt(n))*sqrt(n);
                    northern=mod(i-1,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                    southern=mod(i-1,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    
                    adjList{i}=[eastern western southern northern ne nw se sw];
                end
            case 9
                % Moore lattice, n1992 style, with i as its own neighbor
                % (helps cooperation)
                adjList = cell(1,n);
                for i=1:n
                    ne=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                    nw=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                    se=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    sw=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    eastern=mod(i-2,sqrt(n))+1+mod(floor((i-1)/sqrt(n)),sqrt(n))*sqrt(n);
                    western=mod(i,sqrt(n))+1+mod(floor((i-1)/sqrt(n)),sqrt(n))*sqrt(n);
                    northern=mod(i-1,sqrt(n))+1+mod(floor((i-1)/sqrt(n))-1,sqrt(n))*sqrt(n);
                    southern=mod(i-1,sqrt(n))+1+mod(floor((i-1)/sqrt(n))+1,sqrt(n))*sqrt(n);
                    
                    adjList{i}=[eastern western southern northern ne nw se sw i];
                end
                
        end
    case 'cycle'
        adjList = cell(1,n);
        cur=zeros(1,degree-1);
        for i=1:n
            c=1;
            for j=1:floor(degree/2)
                cur(c)=mod((i-1)+j,n)+1;
                cur(c+1)=mod((i-1)-j,n)+1;
                c=c+2;
            end
            adjList{i}=cur;
        end
    case 'scale-free'
        %BAM
        degree=floor(degree/2);
        adjList = cell(1,n);
        nconnect=zeros(1,n);
        %connect first DEGREE+1th
        for i=1:degree
            adjList{i}=degree+1;
            nconnect(i)=1;
        end
        adjList{degree+1}=1:degree;
        nconnect(degree+1)=degree;
        
        %connect the rest preferentially
        for i=degree+2:n
            tconnect=nconnect;
            for j=1:degree
                choice=ceil(rand*sum(tconnect));
                k=1;
                sumt=cumsum(tconnect);
                while choice > sumt(k)
                    k=k+1;
                end
                
                adjList{k}=[adjList{k} i];
                adjList{i}=[adjList{i} k];
                tconnect(k)=0;
            end
        end
        
    case 'random'
        adjList = cell(1,n);
        numbered=1:n;
        %first, randomly connect the graph
        adjList{1}=2;
        adjList{2}=1;
        connected=zeros(size(n));
        connected(1:2)=1;
        for i=3:n
            possiblefriends=numbered(connected==1);
            newfriend=possiblefriends(ceil(rand*numel(possiblefriends)));
            adjList{i}=newfriend;
            adjList{newfriend}=[adjList{newfriend} i];
            connected(i)=1;
        end
        %average connectivity is now 2. continue connecting
        for i=1:(degree-2)*n/2
            agent=ceil(rand*n);
            connected=zeros(size(n));
            connected(adjList{agent})=1;
            connected(agent)=1;
            possiblefriends=numbered(connected==0);
            if numel(possiblefriends>0)
                newfriend=possiblefriends(ceil(rand*numel(possiblefriends)));
                adjList{agent}=[adjList{agent} newfriend];
                adjList{newfriend}=[adjList{newfriend} agent];
            end
        end
        
    case 'random-regular'
        adjList = cell(1,n);
        numbered=1:n;
        %first, randomly connect the graph, and ensure connectivity does
        %not surpass DEGREE
        adjList{1}=2;
        adjList{2}=1;
        connectable=zeros(size(n));
        connectable(1:2)=1;
        for i=3:n
            possiblefriends=numbered(connectable==1);
            newfriend=possiblefriends(ceil(rand*numel(possiblefriends)));
            adjList{i}=newfriend;
            adjList{newfriend}=[adjList{newfriend} i];
            connectable(i)=1;
            if numel(adjList{newfriend})==degree
                connectable(newfriend)=0;
            end
        end
        %average connectivity is now 2 (almost). continue connecting
        oldcon=zeros(size(connectable));
        while sum(connectable)~=0&&~isequal(oldcon,connectable)
            oldcon=connectable;
            freeagents=numbered(connectable==1);
            agent=freeagents(ceil(rand*numel(freeagents)));
            free=~connectable;
            free(adjList{agent})=1;
            free(agent)=1;
            possiblefriends=numbered(free==0);
            if numel(possiblefriends>0)
                newfriend=possiblefriends(ceil(rand*numel(possiblefriends)));
                adjList{agent}=[adjList{agent} newfriend];
                adjList{newfriend}=[adjList{newfriend} agent];
            end
            if numel(adjList{agent})==degree
                connectable(agent)=0;
            end
            if numel(adjList{newfriend})==degree
                connectable(newfriend)=0;
            end
        end
end
