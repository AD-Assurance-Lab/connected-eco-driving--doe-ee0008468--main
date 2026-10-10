%% Custon_Constructors_POC
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
% Sensors{1}=Mobileye6('Mobileye6',[2 .25 1],[0 0 0],1);
% Sensors{2}=Bosch_MRR_Front('Bosch_MRR_Front',[2.5 0 .4],[0 0 0],2);
% Sensors{3}=Bosch_MRR_Corner('Bosch_MRR_Corner_Left',[1 1 .4],[0 0 90],3);
% Sensors{4}=Bosch_MRR_Corner('Bosch_MRR_Corner_Right',[1 -1 .4],[0 0 -90],4);
% Sensors{5}=Bosch_MRR_Rear('Bosch_MRR_Rear',[-.5 0 .4],[0 0 180],5);
% Sensors{6}=Velodyne_VLP16('Velodyne_VLP16',[1 0 1.5],[0 0 0],6);
Sensors{1}=Mobileye6('Mobileye6',[2 .25 1],[0 0 0],1);
% Sensors{2}=Bosch_MRR_Front('Bosch_MRR_Front',[2.5 0 .4],[0 0 0],2);
Sensors{2}=Bosch_MRR_Corner('Bosch_MRR_Corner_Left',[1 1 .4],[0 0 90],3);
Sensors{3}=Bosch_MRR_Corner('Bosch_MRR_Corner_Right',[1 -1 .4],[0 0 -90],4);
% Sensors{5}=Bosch_MRR_Rear('Bosch_MRR_Rear',[-.5 0 .4],[0 0 180],5);
Sensors{4}=Velodyne_VLP16('Velodyne_VLP16',[1 0 1.5],[0 0 0],6);
%% Sensor Fusion
Tracker=SensorFusion(Sensors,@initcvkf,10,[4 5],5,10,1);
Tracker.InitializePlots();
%% Adding Plots
chasePlot(EgoVehicle)
%% Simulation Run
%Simulation loop
restart(Scenario) %sets scenario.IsRunning to 1
index=0; %initializing simulaiton loop index
%steps the simulation until ending criteria are met

% GraphsBool=0;
GraphsBool=1;
while advance(Scenario)
    %stepping simulation loop index
    index = index +1;
    % Get scenario time
    time = Scenario.SimulationTime;
    disp([index time]);
    
    Tracker.Step(EgoVehicle,time,index,GraphsBool);
    
end