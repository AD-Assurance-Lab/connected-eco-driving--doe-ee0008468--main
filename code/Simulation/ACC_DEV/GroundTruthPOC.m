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
scenario=drivingScenario;
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
RoadCenters=[0 0 0;2000 0 0];
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
road(scenario,RoadCenters,BankingAngle,'Lanes',LaneSpec) 
%% Adding the Ego Vehicle
% initializing the ego vehicle
ClassID=1; %user parameter - recommend 1 for Ego Vehicle
Position=[0 -3 0]; %starting position of the vehicle
vehicle0=vehicle(scenario,'ClassID',ClassID,'Position',Position,'Velocity',[60 0 0]);
%defining the ego vehicle trajectory
% [X,Y]=SplinePoints([0 40 80 120 160 200],[-3 0 3 3 0 -3],1); %creating a
%trajectory based on a spline
X=[100:300:2000]; Y=[-3 -3];
Waypoints=[X;-3*ones(1,numel(X));zeros(1,numel(X))]'; %turning the spline into waypoints n*3
%vector for (x,y,z)
% Speed=65;
%set constant speed either 1*1 for constant or n*1 for varying
% trajectory(EgoVehicle,Waypoints,Speed);

vehicle1=vehicle(scenario,'ClassID',1,'Position',[100 -3 0]);
Speed=50+30*rand(1,numel(X));
trajectory(vehicle1,Waypoints,Speed);

EgoVehicle=ACC_VEH(vehicle0,2000,2000*9.8*.5,-2000*9.8*.5,.1,.01,1,scenario.SampleTime,3,1,[60 80]);

chasePlot(EgoVehicle.vehicle)

%% Simulation Run
%Simulation loop
restart(scenario) %sets scenario.IsRunning to 1
index=0; %initializing simulaiton loop index
%steps the simulation until ending criteria are met
%%
while advance(scenario)
    %stepping simulation loop index
    index = index +1;
%     disp(index)
%     % Get scenario time
    time = scenario.SimulationTime;
    EgoVehicle.Step(scenario,time,index);
%     disp(time)
%     EgoVehicle.Velocity(1)=Speed;
end
figure
subplot(2,1,1)
hold on
plot(EgoVehicle.data.time,EgoVehicle.data.DX,'b')
plot(EgoVehicle.data.time,EgoVehicle.data.targetDX,'r')
subplot(2,1,2)
hold on
plot(EgoVehicle.data.time,EgoVehicle.data.velocity(:,1),'b')
plot(EgoVehicle.data.time,EgoVehicle.data.targetSpeed,'r')