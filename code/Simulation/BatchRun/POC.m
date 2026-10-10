%% POC
%This script builds and runs an automated driving scenario
%in the automated systems driving toolbox. This script will
%either explicitly define all parameters or will provide
%commented-out lines which could be used to do so, as this
%is intended to be used to familiarize a new user with the 
%toolbox for sensor FOV based simulation.
%All units are SI unless explicitly stated otherwise.
%% Clearing variables and objects
clc; clear all; close all;
%% Initializing scenario
%calls an instance of the class "scenario" of the 
%automated systems driving toolbox.
Scenario=drivingScenario;
%the class has the following accessible properties 
%(un-comment to assign value)
% scenario.SampleTime=; %positive real scalar (double)
% scenario.StopTime=; %positive real scalar (double)
% scenario.SimulationTime=; %positive real scalar (double)
% scenario.IsRunning=; %boolean
% scenario.Actors=; %heterogeneous array of Actor and Vehicle objects
%these will automatically be assigned default values
%% Defining Road
%calls function road(varargin) which generates an OpenDRIVE type Road
%need to first define:
RoadCenters=[0 0 0;200 0 0];
%real valued n*3 matrix for (x,y,z) pos of road centerpoint
RoadWidth=[]; %positive, real scalar
BankingAngle=[0 0]; %real n*1 vector; in degrees
NumberOfLanes=[2]; %positive integer
Width=[6]; %m*1 vector of positive real values
Marking=laneMarking('Solid'); %'Unmarked','Solid','Dashed','DoubleSolid','DoubleDashed','SolidDashed','DashedSolid'
LaneSpec=lanespec(NumberOfLanes,'Width',Width,'Marking',Marking);
%road(varargin) can be called using a single road width or 
%with laneSpec
% road(sc,roadcenters,roadwidth,bankingangle)
road(Scenario,RoadCenters,BankingAngle,'Lanes',LaneSpec) 
%% Adding the Ego Vehicle
% initializing the ego vehicle
ClassID=1; %user parameter - recommend 1 for Ego Vehicle
Position=[0 -3 0]; %starting position of the vehicle
EgoVehicle=vehicle(Scenario,'ClassID',ClassID,'Position',Position);
%defining the ego vehicle trajectory
[X,Y]=SplinePoints([0 40 80 120 160 200],[-3 0 3 3 0 -3],1); %creating a
%trajectory based on a spline
Waypoints=[X;Y;zeros(1,numel(X))]'; %turning the spline into waypoints n*3
%vector for (x,y,z)
Speed=interp1([0 40 80 120 160 200],[50 50 50 50 50 50],Waypoints(:,1)); 
%set constant speed either 1*1 for constant or n*1 for varying
trajectory(EgoVehicle,Waypoints,Speed);
%% Adding other actors
% initializing a vehicle
Vehicle1=vehicle(Scenario);
% The accessible properties of the vehicle (un-comment to assign value)
% Vehicle1.ActorID=[]; %index for simulation property Actors 1*1
Vehicle1.ClassID=2; %user classification 1*1
Vehicle1.Position=[100 -3 0]; %initial position of vehicle 1*3
% Vehicle1.Yaw=[]; %initial position of vehicle 1*1
% Vehicle1.Pitch=[]; %initial position of vehicle 1*1
% Vehicle1.Roll=[]; %initial position of vehicle 1*1
% Vehicle1.Velocity=[]; %initial motion of vehicle 1*3
% Vehicle1.AngularVelocity=[]; %initial motion of vehicle 1*3
% Vehicle1.Length=[]; %dimensions of vehicle 1*1
% Vehicle1.Width=[]; %dimensions of vehicle 1*1
% Vehicle1.Height=[]; %dimensions of vehicle 1*1
% Vehicle1.FrontOverhang=[]; %dimensions of vehicle 1*1
% Vehicle1.RearOverhang=[]; %dimensions of vehicle 1*1
% Vehicle1.Wheelbase=[]; %dimensions of vehicle 1*1
% Vehicle1.RCSAzimuthAngles=[]; %vector of <P> azimuth angles where the radar
%intensity of the vehicle is defined. default is [-180 180]
% Vehicle1.RCSElevationAngles=[]; %vector of <Q> elevation angles where the
%radar intensity of the vehicle is defined. default is [-90 90]
% Vehicle1.RCSPattern=[]; %Q by P matrix of radar intensities by azimuth and
%elevation angles such that for a certain azimuth and elevation angle
%the radar intensity of the object may be calcualted. Default: 
%[10 10;10 10]
%initializing a human
Human1=actor(Scenario);
% The accessible properties of the generic actor
%(un-comment to assign value)
% Human1.ActorID=[]; %index for simulation property Actors 1*1
Human1.ClassID=3; %user classification 1*1
Human1.Position=[100 9 0]; %initial position of vehicle 1*3
% Human1.Yaw=[]; %initial position of vehicle 1*1
% Human1.Pitch=[]; %initial position of vehicle 1*1
% Human1.Roll=[]; %initial position of vehicle 1*1
% Human1.Velocity=[]; %initial motion of vehicle 1*3
% Human1.AngularVelocity=[]; %initial motion of vehicle 1*3
Human1.Length=.6; %dimensions of vehicle 1*1
Human1.Width=.25; %dimensions of vehicle 1*1
Human1.Height=2; %dimensions of vehicle 1*1
% Human1.RCSAzimuthAngles=[]; %vector of <P> azimuth angles where the radar
%intensity of the vehicle is defined. default is [-180 180]
% Human1.RCSElevationAngles=[]; %vector of <Q> elevation angles where the
%radar intensity of the vehicle is defined. default is [-90 90]
Human1.RCSPattern=[8 8;8 8]; %Q by P matrix of radar intensities by azimuth and
%elevation angles such that for a certain azimuth and elevation angle
%the radar intensity of the object may be calcualted. Default: 
%[10 10;10 10]
%% Adding Sensors
%vision sensor (Mobileye)
visual1=visionDetectionGenerator();
visual1.DetectorOutput='Lanes and Objects';             %Types of detections generated by sensor
visual1.SensorIndex=1;                %Unique identifier for sensor
visual1.UpdateInterval=.1;            %Required interval between sensor updates
visual1.SensorLocation=[0.75*EgoVehicle.Wheelbase 0];          %Location of sensor center specified in
                                     %vehicle coordinate system
visual1.Height=1.1;                     %Sensor's mounting height from the ground
visual1.Yaw=0;                        %Yaw angle of sensor mounted on ego
                                     %vehicle
visual1.Pitch=0;                      %Pitch angle of sensor mounted on ego
                                     %vehicle
visual1.Roll=0;                       %Roll angle of sensor mounted on ego
                                     %vehicle
% visual1.Intrinsics                 %Sensor's intrinsic camera parameters
% visual1.FieldOfView                %Total angular field of view for sensor
                                     %(read-only)
visual1.MaxRange=200;                   %Maximum detection range
% visual1.MaxSpeed                   %Maximum detectable object speed
% visual1.MaxAllowedOcclusion        %Maximum allowed occlusion for detector
visual1.DetectionProbability=.9;       %Probability of detecting a target
visual1.FalsePositivesPerImage=.1;    %Number of false positives per image
% visual1.MinObjectImageSize         %Minimum image size of an object that can
                                     %be detected
% visual1.BoundingBoxAccuracy        %Bounding box accuracy
% visual1.ProcessNoiseIntensity      %Noise intensity used to filter position
                                     %and velocity measurements
% visual1.HasNoise                   %Add noise to measurements
visual1.MaxNumDetectionsSource='Property';     %Source of maximum number of detections
visual1.MaxNumDetections=3;           %Maximum number of reported detections
% visual1.DetectionCoordinates       %Coordinate system used to report vision
                                     %detections
% visual1.LaneUpdateInterval         %Required interval between lane detection
                                     %updates
% visual1.MinLaneImageSize           %Minimum lane size in image
% visual1.LaneBoundaryAccuracy       %Lane boundary accuracy
visual1.MaxNumLanesSource='Property';           %Source of maximum number of reported
                                     %lanes
visual1.MaxNumLanes=1;                %Maximum number of reported lanes
% visual1.ActorProfiles              %Physical characteristics for all actors
%
%radar sensor Bosch MMR (Front)
radar1=radarDetectionGenerator();
radar1.SensorIndex=2;                %Unique identifier of sensor
radar1.UpdateInterval=.05;             %Required interval between sensor updates
radar1.SensorLocation=[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang 0];             %Location of sensor center specified in
                           %vehicle coordinate system
radar1.Height=.4;                     %Sensor's mounting height from the ground
radar1.Yaw=0;                        %Yaw angle of sensor mounted on ego
                           %vehicle
radar1.Pitch=0;                      %Pitch angle of sensor mounted on ego
                           %vehicle
radar1.Roll=0;                       %Roll angle of sensor mounted on ego
                           %vehicle
radar1.FieldOfView=[56 32];                %Total angular field of view for radar
radar1.MaxRange=60;                   %Maximum detection range
% radar1.RangeRateLimits            %Minimum and maximum range rates that can
                           %be reported
% radar1.DetectionProbability       %Detection probability
% radar1.FalseAlarmRate             %Rate at which false alarms are reported
% radar1.ReferenceRange             %Range where detection probability is
                           %achieved
% radar1.ReferenceRCS               %Target's radar cross section (RCS) at
                           %which detection probability is achieved
% radar1.RadarLoopGain              %Loop gain of radar (read-only)
% radar1.AzimuthResolution          %Azimuthal resolution of radar
% radar1.ElevationResolution        %Elevation resolution of radar
% radar1.RangeResolution            %Range resolution of radar
% radar1.RangeRateResolution        %Range rate resolution of radar
% radar1.AzimuthBiasFraction        %Fractional azimuthal bias component of 
                           %radar
% radar1.ElevationBiasFraction      %Fractional elevation bias component of
                           %radar
% radar1.RangeBiasFraction          %Fractional range bias component of radar
% radar1.RangeRateBiasFraction      %Fractional range rate bias component of
                           %radar
% radar1.HasElevation               %Enable elevation angle measurements
% radar1.HasRangeRate               %Enable range rate measurements
% radar1.HasNoise                   %Add noise to measurements
% radar1.HasFalseAlarms             %Enable false detections
% radar1.HasOcclusion               %Enable line-of-sight occlusion
radar1.MaxNumDetectionsSource='Property';     %Source of maximum number of detections
radar1.MaxNumDetections=32;           %Maximum number of reported detections
% radar1.DetectionCoordinates       %Coordinate system used to report detections
% radar1.ActorProfiles              %Profiles for all actors used to generate
                           %detections
                           
sensors{1}=visual1;
sensors{2}=radar1;
%% Sensor Fusion
tracker = multiObjectTracker(...
            'FilterInitializationFcn',@initcvkf, ...
            'AssignmentThreshold',10,'ConfirmationParameters',[4 5], ...
            'NumCoastingUpdates',5);
        
positionSelector = [1 0 0 0; 0 0 1 0];
        
velocitySelector = [0 1 0 0; 0 0 0 1];
%% Adding Plots
% % Initializing Plots
% %plotting the road from an overhead view
% figure
% plot(Scenario,'Centerline','on','RoadCenters','on');
% %3D view
% figure
% plot(Scenario,'Centerline','on','RoadCenters','on');
% view(-60,30);
% figure
% % "Chase plot" - animation from behind the vehicle
chasePlot(EgoVehicle)
% Create bird's eye plotter
% bep = birdsEyePlot('XLimits',[-10 20],'YLimits',[-10 10]);

% Create coverage area plotter
% cap{1} = coverageAreaPlotter(bep,'FaceColor','blue','EdgeColor','blue');
% cap{2} = coverageAreaPlotter(bep,'FaceColor','red','EdgeColor','red');

% detPlotter = detectionPlotter(bep,'DisplayName','Object detections');
% lmPlotter = laneMarkingPlotter(bep,'DisplayName','Lane markings');
% lbPlotter = laneBoundaryPlotter(bep,'DisplayName', 'Lane boundary detections','Color','green');
% olPlotter = outlinePlotter(bep);
% Plot coverage area
% plotCoverageArea(cap{1},sensors{1}.SensorLocation,sensors{1}.MaxRange,sensors{1}.Yaw,45);
% plotCoverageArea(cap{2},sensors{2}.SensorLocation,sensors{2}.MaxRange,sensors{2}.Yaw,sensors{2}.FieldOfView(1));


% Create detection plotter
% bepPlotters.vision = detectionPlotter(bep,'DisplayName','vision','MarkerEdgeColor','blue','Marker','^');
% bepPlotters.radar = detectionPlotter(bep,'DisplayName','radar','MarkerEdgeColor','green','Marker','x');
 
% Create track plotter
% bepPlotters.track = trackPlotter(bep,'DisplayName','track','HistoryDepth',10);
%% Simulation Run
%Simulation loop
restart(Scenario) %sets scenario.IsRunning to 1
index=0; %initializing simulaiton loop index
%steps the simulation until ending criteria are met
% Data=struct('Time',[],'TP',[],'LMV',[],'LMF',
Data=struct('empty',[]);
NMessages=32;
SignalNames={'dx','dy','vx','vy','ax','ay'};
for i=1:1:NMessages
    for j=1:1:numel(SignalNames)
        c=SignalNames(j); s=c{:};
        Data.(sprintf('Radar1_obj%i_%s',i,s))=[];
    end
end
DataFields=fields(Data);
VData=struct('empty',[],'heading',[],'curvature',[],'offset',[]);
NMessages=3;
SignalNames={'dx','dy','vx','vy','ax','ay'};
for i=1:1:NMessages
    for j=1:1:numel(SignalNames)
        c=SignalNames(j); s=c{:};
        Data.(sprintf('Vision1_obj%i_%s',i,s))=[];
    end
end
VDataFields=fields(VData);
%%
sen=Mobileye6('Mobileye6',[0.75*EgoVehicle.Wheelbase 0 1.1],[0 0 0],1);
sen1=Radar_Front('Radar1',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang 0 .4],[0 0 0]);
while advance(Scenario)
    %stepping simulation loop index
    index = index +1;
    disp(index);
    % Get scenario time
    time = Scenario.SimulationTime;
    disp(time);
    
    TP = targetPoses(EgoVehicle);
    [LMV,LMF] = laneMarkingVertices(EgoVehicle);
%     plotLaneMarking(lmPlotter,LMV,LMF)
    LookAheadDistance = 0:0.5:200;
    LB = laneBoundaries(EgoVehicle,'XDistance',LookAheadDistance,'LocationType','center', 'AllBoundaries', true);
    % Simulate sensors
    [Visual1Dets,NumValidVisual1Dets,~,LBDets] = sensors{1}(TP,LB,time);
    [Radar1Dets,NumValidRadar1Dets,SensorValid(2)] = sensors{2}(TP,time);
    VData.curvature(index)=LBDets.LaneBoundaries(1).Curvature;
    VData.heading(index)=LBDets.LaneBoundaries(1).HeadingAngle;
    VData.offset(index)=LBDets.LaneBoundaries(1).LateralOffset;
    sen.Detections(TP,LB,time,index);
    sen1.Detections(TP,time,index);
%     return
  
   
%     [ObjPosition,ObjYaw,ObjLength,ObjWidth,ObjOriginOffset,Color] = targetOutlines(EgoVehicle);
%     plotOutline(olPlotter,ObjPosition,ObjYaw,ObjLength,ObjWidth,'OriginOffset',ObjOriginOffset,'Color', Color)
  
    % Edit detections and get detection positions
    for i = 1:1:numel(Visual1Dets)
        VData.(sprintf('Visual1_obj%i_%s',i,'dx'))(index)=Visual1Dets{i}.Measurement(1);
        VData.(sprintf('Visual1_obj%i_%s',i,'dy'))(index)=Visual1Dets{i}.Measurement(2);
        VData.(sprintf('Visual1_obj%i_%s',i,'vx'))(index)=Visual1Dets{i}.Measurement(3);
        VData.(sprintf('Visual1_obj%i_%s',i,'vy'))(index)=Visual1Dets{i}.Measurement(4);
        VData.(sprintf('Visual1_obj%i_%s',i,'ax'))(index)=Visual1Dets{i}.Measurement(5);
        VData.(sprintf('Visual1_obj%i_%s',i,'ay'))(index)=Visual1Dets{i}.Measurement(6); 
    end
    for i = 1:1:numel(Radar1Dets)
        c=DataFields(i); s=c{:};
        Data.(sprintf('Radar1_obj%i_%s',i,'dx'))(index)=Radar1Dets{i}.Measurement(1);
        Data.(sprintf('Radar1_obj%i_%s',i,'dy'))(index)=Radar1Dets{i}.Measurement(2);
        Data.(sprintf('Radar1_obj%i_%s',i,'vx'))(index)=Radar1Dets{i}.Measurement(3);
        Data.(sprintf('Radar1_obj%i_%s',i,'vy'))(index)=Radar1Dets{i}.Measurement(4);
        Data.(sprintf('Radar1_obj%i_%s',i,'ax'))(index)=Radar1Dets{i}.Measurement(5);
        Data.(sprintf('Radar1_obj%i_%s',i,'ay'))(index)=Radar1Dets{i}.Measurement(6); 
    end
     
    % Plot detections
%     if(numel(SensorDets1))
%     plotDetection(bepPlotters.vision,VisionPos);
%     end
%     
%     if(numel(SensorDets2))
%     plotDetection(bepPlotters.radar,RadarPos);
%     end
    
%     if LBValid
%         plotLaneBoundary(lbPlotter,vertcat(LBDets.LaneBoundaries))
%     end
    % Create object detection report
%     detections = [SensorDets1;SensorDets2];
    
    % Update and visualize tracks
%     if (any([SensorValid(1) SensorValid(2)]))
%         confirmedTracks = updateTracks(tracker,detections,time);
%         trackIDs = {confirmedTracks.TrackID};
%         trackLabels = cellfun(@num2str, trackIDs, 'UniformOutput', false);
%         [trackPositions,trackCovariances] = getTrackPositions(confirmedTracks,positionSelector);
%         trackVelocities = getTrackVelocities(confirmedTracks,velocitySelector);
%         plotTrack(bepPlotters.track,trackPositions,trackVelocities,trackCovariances,trackLabels);
%         
%     end
%     if ~isempty(SensorDets1)
%         return
%     end
%     return
end