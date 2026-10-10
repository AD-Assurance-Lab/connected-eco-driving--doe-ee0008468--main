%% Traffic Lights projection onto Ego Path
%% Parameter Inputs
n=.5; %interval in meters for distance interpolation
LapIndices=[23456 32514]; %indices for the lap in question
numLights=4; %number of traffic lights ahead of vehicle to record
%% Data in
load('InterpolatedData_8_1_10Hz_SF.mat'); %loading interpolated data
%% Make Cut Interp Data
Lap2InterpolatedData=struct('data',[],'time',[]);
Lap2InterpolatedData.time=InterpolatedData.time(LapIndices(1):LapIndices(2));
for i=1:1:numel(InterpolatedData.data)
    Lap2InterpolatedData.data(i).name=InterpolatedData.data(i).name;
    Lap2InterpolatedData.data(i).data=InterpolatedData.data(i).data(LapIndices(1):LapIndices(2));
end
save('Lap2InterpolatedData.mat','Lap2InterpolatedData');
%% Making new ego vehicle with equal distance steps
EgoLatLon=[InterpolatedData.data(43).data(LapIndices(1):LapIndices(2))' ...
    InterpolatedData.data(42).data(LapIndices(1):LapIndices(2))']; %vector of latlons for Ego vehicle
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
EgoDistances=EgoDistances*1000; %converting to meters
CumEgoDistance=CumEgoDistance*1000; %converting to meters
NewDistances=[0:n:CumEgoDistance(end)];
NewLat=interp1(CumEgoDistance,EgoLatLon(:,1),NewDistances); %interpolating lat
NewLon=interp1(CumEgoDistance,EgoLatLon(:,2),NewDistances); %interpolating lon
NewEgoLatLon=[NewLat',NewLon',NewDistances']; %new matrix of nterpolated lat, lon, and dist\
%% Figure for Validation
figure; hold on
plot(EgoLatLon(:,2),EgoLatLon(:,1),'b')
plot(NewEgoLatLon(:,2),NewEgoLatLon(:,1),'--r')
%% Interpolating Time Vector
NewTime=interp1(CumEgoDistance,InterpolatedData.time(LapIndices(1):LapIndices(2)),NewDistances);
%% Making the structure
EgoDataByDist=struct('time',[],'latitude',[],'longitude',[],'distance',[],'TSP',[],'LV',[]);
%% Adding the points
for i=1:1:numel(NewDistances)
    EgoDataByDist(i).time=NewTime(i);
    EgoDataByDist(i).latitude=NewLat(i);
    EgoDataByDist(i).longitude=NewLon(i);
    EgoDataByDist(i).distance=NewDistances(i);
    EgoDataByDist(i).TSP=struct('indices',[],'distances',[],'phases',[]);
    EgoDataByDist(i).V2I=struct('index',[],'speed',[],'distanceRemaining',[]);
    EgoDataByDist(i).LV=struct('dx',[],'dy',[],'vx',[]);
end
%% Placing the Traffic Signals
%% Traffic Signal Locations
[~,~,raw]=xlsread('TrafficSignalLocations.xlsx'); %traffic signal locations
intersections=[...
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
    {'College'},{'Laurel'};...
    {'Mulberry'},{'College'}];
InterpolatedTSP=zeros(numel(intersections(:,1)),numel(NewDistances));
for i=1:1:numel(intersections(:,1)) %pulling for the intersections
    [IntersectionGPS(i,:)]=PullTrafficSignalLatLon(string(intersections{i,1}),string(intersections{i,2}),raw);
    for j=1:1:numel(InterpolatedData.data)
        if regexp(InterpolatedData.data(j).name,string(intersections{i,1}))
            if regexp(InterpolatedData.data(j).name,string(intersections{i,2}))
                tempPhases=InterpolatedData.data(j).data(LapIndices(1):LapIndices(2));
                break
            end
        end
    end
    InterpolatedTSP(i,:)=interp1(CumEgoDistance,tempPhases,NewDistances); %interpolating lat
end
%% Interpolating V2I
Segments=[{'CollegeProspectToMulberry'},...
    {'MulberryCollegeToShields'},...
    {'ProspectShieldsToCollege'},...
    {'ShieldsMulberryToProspect'},...
    {'ShieldsProspectToDrake'}];
InterpolatedV2I=zeros(5,numel(NewDistances));
for i=1:1:5 %pulling for the segments
    [IntersectionGPS(i,:)]=PullTrafficSignalLatLon(string(intersections{i,1}),string(intersections{i,2}),raw);
    for j=1:1:numel(InterpolatedData.data)
        if regexp(InterpolatedData.data(j).name,Segments{i})
            if regexp(InterpolatedData.data(j).name,'SegmentSpeed')
                tempV2I=InterpolatedData.data(j).data(LapIndices(1):LapIndices(2));
                break
            end
        end
    end
    InterpolatedV2I(i,:)=interp1(CumEgoDistance,tempV2I,NewDistances); %interpolating lat
end
% 1. CollegeProspectToMulberry
% 2. MulberryCollegeToShields
% 3. ProspectShieldsToCollege
% 4. ShieldsMulberryToProspect
% 5. ShieldsProspectToDrake
%% KNN Search
TrafficSignalIndices=knnsearch(NewEgoLatLon(:,1:2),IntersectionGPS);
%% PseudoCode for sort function

% loop on all integration points on Ego trace
% 1. Time - exists
% 
% 2. Traffic lights (TSP):
% 	indices onf next m traffic lights
% 	distances to next m traffic lights along ego path
% 	phases of the signals for each of the m lights
% 	
% 3. Segments (V2I):
% 	Currnet segment index
% 	current segment speed
% 	dist along segment (relative to segment) HEURISTIC TIME!
% 	
% 4. Historical data (V2V):
% 	Mu and Sigma for Speeds of "historical traces" at ego latlon
% 	
% 5. ADAS:
% 	Lead vehicle dx, dy, and vx
% 	other vehicles dx, dy, and vx
% 	(remember that all data with dx<=.5 is spurious)
% One loop
% Functions for each section of data
% for i=1:1:numel(EgoDataByDist)
    %Call lights function
    %Call segmnents function
    %Call ADAS function
% end
%% Finding Indices in ADAS
indices=struct('dx',[],'dy',[],'vx',[]);
for i = 1:1:numel(InterpolatedData.data)
    if regexp(InterpolatedData.data(i).name, 'dx')
        indices.dx(1)=i;
        break
    end
end
indices.dx=[indices.dx(1):4:numel(InterpolatedData.data)];
indices.dy=[indices.dx(1)+1:4:numel(InterpolatedData.data)];
indices.vx=[indices.dx(1)+2:4:numel(InterpolatedData.data)];
%% Placing the Traffic Lights
j=1;
tic
for i=1:1:numel(EgoDataByDist)
    [EgoDataByDist,j]=AssignTrafficSignals(EgoDataByDist,TrafficSignalIndices,InterpolatedTSP,i,j,numLights);
    [EgoDataByDist,j]=AssignV2ISegments(EgoDataByDist,TrafficSignalIndices,InterpolatedV2I,i,j);
    [EgoDataByDist,j]=AssignADAS(EgoDataByDistLap2InterpolatedData,i,j,indices);
%     EgoDataByDist(i).TSP.indices(1)=(j);
%     EgoDataByDist(i).TSP.distances(1)=lldistkm(NewEgoLatLon(i,:),IntersectionGPS(j,:))*1000;
% %     EgoDataByDist(i).TSP.phases(1)=interp1( %figure this out later so
% %     D01 can go to the gym
%     if i==IDX(j)
%         j=j+1;
%     end
%     if j>numel(IDX)
%         j=1;
%     end
% if rem(i,1000)==0
    disp(i)
% end
end
disp(toc)
%% Validation Plot 2
TrafficSignalIndex=zeros(numel(EgoDataByDist),1);
for i=1:1:numel(EgoDataByDist)
    TrafficSignalIndex(i)=EgoDataByDist(i).TSP.indices(1);
end
figure; hold on
scatter(NewEgoLatLon(:,2),NewEgoLatLon(:,1),10,TrafficSignalIndex/max(TrafficSignalIndex))
%%
LV=zeros(1,numel(EgoDataByDist));
for i=1:1:numel(EgoDataByDist)
    LV(i)=sqrt(EgoDataByDist(i).LV.dx^2+EgoDataByDist(i).LV.dy^2);
end