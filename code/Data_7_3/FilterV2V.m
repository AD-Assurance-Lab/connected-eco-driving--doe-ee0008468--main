function [V2V]=FilterV2V(V2V)
% This function cleans up spurrious V2V data points and adds speed
for i=1:1:numel(V2V)
    longitude=V2V(i).data.longitude(1,:);
    latitude=V2V(i).data.latitude(1,:);
    time=V2V(i).data.latitude(2,:); %time index is same for both
    indices=longitude<0; %removing spurrious GPS positions
    longitude=longitude(indices)/10^6;
    latitude=latitude(indices)/10^6;
    time=time(indices);
    dist=zeros(1,numel(longitude)); %distance in km
    for j=2:1:numel(longitude)
        dist(j)=lldistkm([latitude(j-1) longitude(j-1)],[latitude(j) longitude(j)]);
    end
    difftime=diff(time);
    difftime=[difftime(1) difftime];
%     disp([numel(dist) numel(difftime) numel(indices)])
    speed=dist./difftime*3600; %speed in kmh
    V2V(i).data.longitude=[longitude;time];
    V2V(i).data.latitude=[latitude;time];
    V2V(i).data.distance=[dist;time];
    V2V(i).data.speed=[speed;time];
end