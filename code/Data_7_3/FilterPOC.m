%% Synchronizing V2V
longitude=RawData.V2V(2).data.longitude(1,:);
latitude=RawData.V2V(2).data.latitude(1,:);
time=RawData.V2V(2).data.latitude(2,:);
indices=longitude<0;
figure
longitude=longitude(indices)/10^6;
latitude=latitude(indices)/10^6;
time=time(indices)-time(1);
scatter(longitude,latitude);
%%
dist=zeros(1,numel(longitude)); %distance in km
for i=2:1:numel(longitude)
    dist(i)=lldistkm([latitude(i-1) longitude(i-1)],[latitude(i) longitude(i)]);
end
difftime=diff(time);
difftime=[difftime(1) difftime];
speed=dist./difftime*3600; %speed in kmh
scatter(longitude,latitude,10,speed/max(speed))
%%
scatter3(longitude,latitude,speed,20,time/max(time))
%%
% figure
% hold on
% plot(dist*1000,'b')
% plot(difftime,'r')
%%
V2V=FilterV2V(RawData.V2V);
figure
hold on
for i=1:1:numel(V2V)
    scatter3(V2V(i).data.longitude(1,:),V2V(i).data.latitude(1,:),V2V(i).data.speed(1,:),20,[i/3 1 0])
end
%%
longitude=RawData.EGO.data.longitude(1,:);
latitude=RawData.EGO.data.latitude(1,:);
time=RawData.EGO.data.latitude(2,:);
indices=[1:1:numel(longitude)];
% indices=longitude<0;
figure
longitude=longitude(indices)/10^6;
latitude=latitude(indices)/10^6;
time=time(indices)-time(1);
scatter(longitude,latitude);