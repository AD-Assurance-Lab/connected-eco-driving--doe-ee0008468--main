%% Script for Pullign All Data by distance
%% Traffic Signal Locations
[~,~,raw]=xlsread('TrafficSignalLocations.xlsx'); %traffic signal locations
intersections=[...
    {'Mulberry'},{'College'};...
    {'Mulberry'},{'Mason'};...
    {'Mulberry'},{'Howes'};...
    {'Mulberry'},{'Meldrum'};...
    {'Mulberry'},{'Sherwood'};...
    {'Mulberry'},{'Loomis'};...
    {'Mulberry'},{'Shields'};...
    {'Shields'},{'Laurel'};...
    {'Shields'},{'Plum'};...
    {'Shields'},{'Elizabeth'};...
    {'Shields'},{'Springfield'};...
    {'Shields'},{'Lake'};...
    {'Shields'},{'Prospect'};...
    {'Shields'},{'Stuart'};...
    {'Shields'},{'Rolland Moore'};...
    {'Shields'},{'Raintree'};...
    {'Centre'},{'Prospect'};...
    {'Prospect'},{'MAX Guideway'};...
    {'Prospect'},{'College'};...
    {'College'},{'Pitkin'};...
    {'College'},{'Elizabeth'};...
    {'College'},{'Laurel'}];
for i=1:1:numel(intersections(:,1)) %pulling for the intersections
    [IntersectionGPS(i,:)]=PullTrafficSignalLatLon(string(intersections{i,1}),string(intersections{i,2}),raw);
end
%% LatLons for Roads
% Longitude is E/W negative for West
% Latitude is N/S positive for North
% format is [lat, lon]
[~,~,raw2]=xlsread('tomtom_network_w_grade.csv');
RoadGPS=struct('Mulberry',[],'Shields',[],'Centre',[],'Prospect',[],'College',[]);
[RoadGPS.Mulberry]=PullGPSFromTomTomDataByRoad(raw2,'Mulberry');
[RoadGPS.Shields]=PullGPSFromTomTomDataByRoad(raw2,'Shields');
[RoadGPS.Centre]=PullGPSFromTomTomDataByRoad(raw2,'Centre');
[RoadGPS.Prospect]=PullGPSFromTomTomDataByRoad(raw2,'Prospect');
[RoadGPS.College]=PullGPSFromTomTomDataByRoad(raw2,'College');
%% Cleaning up Centre
figure
hold on
plot(RoadGPS.Centre(:,2),RoadGPS.Centre(:,1),'or');
badPoints=[]; j=0;
for i=1:1:numel(RoadGPS.Centre(:,1))
    lat=RoadGPS.Centre(i,1);
    lon=RoadGPS.Centre(i,2);
    if lon<-105.0848 && lon>-105.0864
        if lat>40.5645 && lat<40.567
            j=j+1;
            badPoints(j)=i;
        end
    end
end
indices=1:1:numel(RoadGPS.Centre(:,1));
indices(badPoints)=0;
RoadGPS.Centre=RoadGPS.Centre(indices~=0,:);
plot(RoadGPS.Centre(:,2),RoadGPS.Centre(:,1),'ok');
%% Plotting the Roads
figure
hold on
plot(RoadGPS.Mulberry(:,2),RoadGPS.Mulberry(:,1),'ob')
plot(RoadGPS.Shields(:,2),RoadGPS.Shields(:,1),'or')
plot(RoadGPS.Centre(:,2),RoadGPS.Centre(:,1),'om')
plot(RoadGPS.Prospect(:,2),RoadGPS.Prospect(:,1),'oc')
plot(RoadGPS.College(:,2),RoadGPS.College(:,1),'og')
%% Plotting the Traffic Signals
for i=1:1:numel(IntersectionGPS(:,1))
    plot(IntersectionGPS(i,2),IntersectionGPS(i,1),'ok','MarkerSize',15)
end
%% Plotting the Route GPS
load('InterpolatedData_8_1_10Hz_SF.mat');
RouteGPS=[InterpolatedData.data(43).data;InterpolatedData.data(42).data]';
figure
hold on
plot(RouteGPS(:,2),RouteGPS(:,1),'ob')
for i=1:1:numel(IntersectionGPS(:,1))
    plot(IntersectionGPS(i,2),IntersectionGPS(i,1),'ok','MarkerSize',15)
end