%% Parse Tracks Into Data
numTracks=zeros(1,numel(DataOut));
for i=1:1:numel(DataOut)
    numTracks(i)=numel(DataOut(i).tracks);
end
maxNumTracks=max(numTracks);
%%
tempTracks=struct('dx',[],'dy',[],'vx',[],'target',[]);
%%
for i=1:1:numel(DataOut)
    for j=1:1:numel(DataOut(i).tracks)
        tempTracks(j).dx(i)=DataOut(i).tracks(j).State(1);
        tempTracks(j).dy(i)=DataOut(i).tracks(j).State(4);
        tempTracks(j).vx(i)=DataOut(i).tracks(j).State(2);
        if numel(DataOut(i).tracks(j).ObjectAttributes)>1
            tempTracks(j).target(i)=0;
        else
            tempTracks(j).target(i)=DataOut(i).tracks(j).ObjectAttributes{1}{1};
        end
    end
end
%%
Tracks=struct('name','','data',[]);
j=0;
for i=1:1:maxNumTracks
    j=j+1;
    Tracks(j).name=sprintf('SF_%i_track_%i_dx',j,i);
    Tracks(j).data=tempTracks(i).dx;
    j=j+1;
    Tracks(j).name=sprintf('SF_%i_track_%i_dy',j,i);
    Tracks(j).data=tempTracks(i).dy;
    j=j+1;
    Tracks(j).name=sprintf('SF_%i_track_%i_vx',j,i);
    Tracks(j).data=tempTracks(i).vx;
    j=j+1;
    Tracks(j).name=sprintf('SF_%i_track_%i_target',j,i);
    Tracks(j).data=tempTracks(i).target;
end