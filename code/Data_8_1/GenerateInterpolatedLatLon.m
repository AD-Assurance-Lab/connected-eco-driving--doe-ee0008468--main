function [NewLatLon]=GenerateInterpolatedLatLon(InterpolatedData,n)
%% Making new ego vehicle with equal distance steps
EgoLatLon=[InterpolatedData.data(43).data' InterpolatedData.data(42).data']; %vector of latlons for Ego vehicle
EgoDistances=zeros(numel(EgoLatLon(:,1)),1); %initialiing vector for distanvces
CumEgoDistance=zeros(numel(EgoLatLon(:,1)),1); %initialiing vector for cumulative distanvces
for i=2:1:numel(EgoDistances)
    %Calculating the distances between the Ego latlon points along the
    %trace in km
    EgoDistances(i)=lldistkm(EgoLatLon(i-1,:),EgoLatLon(i,:));
    if EgoDistances(i)==0 %making each point "unique"
        EgoDistances(i)=.000000001;
    end
    CumEgoDistance(i)=CumEgoDistance(i-1)+EgoDistances(i);
end
% EgoDistances=EgoDistances*1000;
CumEgoDistance=CumEgoDistance*1000; %converting to meters
NewDistances=[0:n:CumEgoDistance(end)];
NewLat=interp1(CumEgoDistance,EgoLatLon(:,1),NewDistances); %interpolating lat
NewLon=interp1(CumEgoDistance,EgoLatLon(:,2),NewDistances); %interpolating lon
NewTime=interp1(CumEgoDistance,InterpolatedData.time,NewDistances);
% assignin('base','out1',EgoDistances);
% assignin('base','out2',NewTime);
speed=[0 diff(NewDistances)./diff(NewTime)];
NewLatLon=struct('lat',NewLat,'lon',NewLon,'speed',speed,'dist',NewDistances,'oldDist',CumEgoDistance','time',NewTime,'oldTime',InterpolatedData.time); %new struct of nterpolated lat, lon, and dist\
end