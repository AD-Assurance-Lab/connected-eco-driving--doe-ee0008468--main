clc; clear all; close all; addpath(genpath(pwd))
%% Generate Scenario
scenario = drivingScenario;
scenario.SampleTime = 0.005;
% Define straight road
roadCenters = [29.3 32.8 0;
    169.1 33.3 0;
    192.1 35.6 0;
    212.2 43.5 0;
    303.9 140.6 0];
laneSpecification = lanespec(3, 'Width', 3.7);
road(scenario, roadCenters, 'Lanes', laneSpecification);


% Add the non-ego actors
egoCar = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [61.6 32 0]);
waypoints = [61.6 32 0;
    144.9 32.4 0;
    150.4 32.5 0;
    155.5 34.1 0;
    160.6 36.2 0;
    170.1 37.1 0;
    179.1 37.4 0;
    186.4 38 0;
    198.1 41.1 0;
    206.7 41.3 0;
    217.9 47.4 0;
    226.2 51.8 0;
    235.5 58.9 0;
    243 64.9 0;
    251.4 73.1 0;
    265.2 87.9 0;
    277.3 103.1 0;
    285.4 113.6 0];
speed = 40;
trajectory(egoCar, waypoints, speed);

% Add the non-ego actors
actor_vehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [89.7 31.2 0]);
waypoints = [89.7 31.2 0;
    157.3 33 0;
    174.5 33.8 0;
    181.4 34.1 0;
    188.7 34.9 0;
    196.7 37.3 0;
    202.9 39.7 0;
    209.7 43.2 0;
    217.5 47.2 0;
    226.4 52.5 0;
    235.4 59.1 0;
    242.5 64.79 0.01;
    249.51 71.54 0.01;
    256.9 79.3 0;
    265.38 88.41 0.01;
    276.59 102.31 0.01;
    285.2 113.6 0;
    292.79 124.71 0.01;
    300.42 135.37 0.01];
speed = [43;43;43;43;43;43;43;43;43;43;43;43;43;43;43;43;1;43;43];
trajectory(actor_vehicle, waypoints, speed);

car = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [77.6 36.1 0]);
waypoints = [77.6 36.1 0;
    172.7 37.1 0;
    186 38.2 0;
    196.8 40.9 0;
    209.2 46.3   0;
    225.4 55.8 0;
    240.2 66.8 0;
    256.9 83.7 0;
    270.7 100.6 0;
    299.7 140.2 0];
speed = [50;50;50;50;50;50;50;50;50;1];
trajectory(car, waypoints, speed);

car1 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [77.6 27.9 0]);
waypoints = [77.6 27.9 0;
    164.8 29.3 0;
    175.2 29.7 0;
    186.8 30.6 0;
    198.4 33.1 0;
    210.3 38.5 0;
    222.1 44.7 0;
    231.8 50.9 0;
    240.2 57.6 0;
    248.4 64.1 0;
    254.9 70.5 0;
    262.3 78.2 0;
    268.8 86.1 0;
    277.2 96.2 0;
    284.6 106.4 0;
    290.7 115 0;
    298 124.8 0;
    306.2 137.1 0];
speed = [45;45;45;45;45;45;45;45;45;45;45;45;45;45;45;45;1;45];
trajectory(car1, waypoints, speed);

car2 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [51.4 36 0]);
waypoints = [51.4 36 0;
    113.2 35.7 0;
    158 36.9 0;
    186.2 38.2 0;
    197.2 40.9 0;
    209.4 46.1 0;
    226.1 56 0;
    240.7 67 0;
    257.1 83.2 0;
    271.1 100.8 0];
speed = 39;
trajectory(car2, waypoints, speed);

car3 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [35 28.8 0]);
waypoints = [35 28.8 0;
    99.2 28.5 0;
    132.6 28.9 0;
    149 28.9 0;
    169.6 29.2 0;
    182.7 30.3 0;
    198.9 33.2 0;
    213.6 39.5 0;
    228.1 48.2 0;
    240.3 57.9 0;
    250.5 65.9 0;
    260.9 77 0;
    268.4 85.3 0;
    276.9 96.5 0;
    284.5 105.9 0];
speed = 45;
trajectory(car3, waypoints, speed);

car4 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [32.9 32.6 0]);
waypoints = [32.9 32.6 0;
    123.8 32.3 0;
    133.7 32.5 0;
    148.7 32.9 0;
    159.5 32.9 0;
    174 33.8 0;
    189 35.1 0;
    203.1 39.5 0;
    217.6 47 0;
    226.4 51.9 0;
    234.5 58.5 0;
    242.9 65.1 0;
    249.9 71.7 0;
    257 79.1 0;
    265.7 88.8 0];
speed = 39;
trajectory(car4, waypoints, speed);
%% Adding Sensors
Sensors{1}=Mobileye6('Mobileye6',[egoCar.Wheelbase*.75 egoCar.Width/4 egoCar.Height*.95],[0 0 0],1);
Sensors{2}=Bosch_MRR_Front('Bosch_MRR_Front',[egoCar.Wheelbase+egoCar.FrontOverhang 0 egoCar.Height*.4],[0 0 0],[2 3]);
Sensors{3}=Bosch_MRR_Corner('Bosch_MRR_Corner_Left',[0 egoCar.Width/2 egoCar.Height*.4],[0 0 90],4);
Sensors{4}=Bosch_MRR_Corner('Bosch_MRR_Corner_Right',[0 -egoCar.Width/2 egoCar.Height*.4],[0 0 -90],5);
Sensors{5}=Bosch_MRR_Rear('Bosch_MRR_Rear',[-egoCar.RearOverhang 0 egoCar.Height*.4],[0 0 180],[6 7]);
Sensors{6}=Velodyne_VLP16('Velodyne_VLP16',[egoCar.Wheelbase*.75 0 egoCar.Height+.05],[0 0 0],8);
% Sensors{7}=Mobileye6('Mobileye6',[-egoCar.RearOverhang 0 egoCar.Height],[0 0 180],7);
% Sensors{1}=Mobileye6('Mobileye6',[egoCar.Wheelbase*.75 egoCar.Width/4 egoCar.Height*.95],[0 0 0],1);
% Sensors{1}=Bosch_MRR_Front('Bosch_MRR_Front',[egoCar.Wheelbase+egoCar.FrontOverhang 0 egoCar.Height*.4],[0 0 0],1);
% Sensors{2}=Bosch_MRR_Corner('Bosch_MRR_Corner_Left',[0 egoCar.Width/2 egoCar.Height*.4],[0 0 90],2);
% Sensors{3}=Bosch_MRR_Corner('Bosch_MRR_Corner_Right',[0 -egoCar.Width/2 egoCar.Height*.4],[0 0 -90],3);
% Sensors{4}=Bosch_MRR_Rear('Bosch_MRR_Rear',[-egoCar.RearOverhang 0 egoCar.Height*.4],[0 0 180],4);
% Sensors{5}=Velodyne_VLP16('Velodyne_VLP16',[egoCar.Wheelbase*.75 0 egoCar.Height+.05],[0 0 0],5);
%% Sensor Fusion
Tracker=SensorFusion(Sensors,@initcvkf,7,[6 10],2,200,2);
bep=birdsEyePlot('XLimits',[-25 25],'YLimits',[-15 15]);
Tracker.InitializePlots(bep);
%% Adding Plots
% chasePlot(EgoVehicle)
%% Simulation Run
%Simulation loop
restart(scenario) %sets scenario.IsRunning to 1
index=0; %initializing simulaiton loop index
%steps the simulation until ending criteria are met

% GraphsBool=0;
GraphsBool=1;
while advance(scenario)
    %stepping simulation loop index
    index = index +1;
    % Get scenario time
    time = scenario.SimulationTime;
    disp([index time]);
    
    Tracker.Step(egoCar,time,index,GraphsBool);
%     if index==16
%         return 
%     end
    
end