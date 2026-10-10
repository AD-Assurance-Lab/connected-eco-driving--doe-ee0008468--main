clc, clear, close all

%% Generate Scenario
scenario = drivingScenario;
scenario.SampleTime = 0.01;
% Define straight road
roadCenters = [34.27 -1.33 0;
    34.8 12.93 0;
    20.78 13.83 0;
    20.32 -1.4 0;
    34.27 -1.33 0];
marking = [laneMarking('Solid', 'Width', 0.25)
    laneMarking('Solid')
    laneMarking('Solid', 'Width', 0.25)];
laneSpecification = lanespec(2, 'Width', 5.925, 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [29.2 -5.729 0;
    29.2 -156.1 0];
marking = [laneMarking('Solid', 'Color', [0 0 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Solid', 'Color', [0 0 0])];
laneSpecification = lanespec(4, 'Width', [2.9625 2.9625 3.6 3.6], 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [29 132.1 0;
    29 19.78 0];
marking = [laneMarking('Solid', 'Color', [0 0 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Solid', 'Color', [0 0 0])];
laneSpecification = lanespec(4, 'Width', [2.9625 2.9625 3.6 3.6], 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [14 6.1 0;
    -47.2 6.1 0];
marking = [laneMarking('Solid', 'Color', [0 0 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Solid', 'Color', [0 0 0])];
laneSpecification = lanespec(4, 'Width', [3.9625 2.9625 3.6 2.9825], 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [103.1 6.1 3;
    40.7 6.1 0];
marking = [laneMarking('Solid', 'Color', [0 0 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Solid', 'Color', [0 0 0])];
laneSpecification = lanespec(4, 'Width', [3.9625 2.9625 3.6 2.9825], 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [109.5 133.2 3;
    109.2 -156.1 3];
marking = [laneMarking('Solid', 'Color', [0 0 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Solid', 'Color', [0 0 0])];
laneSpecification = lanespec(4, 'Width', [2.9625 2.9625 3.6 3.6], 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [-53.38 129 0;
    -53.38 -141.1 0];
marking = [laneMarking('Solid', 'Color', [0 0 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Solid', 'Color', [0 0 0])];
laneSpecification = lanespec(4, 'Width', [2.9625 2.9625 3.6 3.6], 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [103.3 -130.5 3;
    35.3 -130.5 0];
marking = [laneMarking('Solid', 'Color', [0 0 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Solid', 'Color', [0 0 0])];
laneSpecification = lanespec(4, 'Width', [3.9625 2.9625 3.6 2.9825], 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [25.2 -130.5 0;
    -47.2 -130.5 0];
marking = [laneMarking('Solid', 'Color', [0 0 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Solid', 'Color', [0 0 0])];
laneSpecification = lanespec(4, 'Width', [3.9625 2.9625 3.6 2.9825], 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [104.5 118.7 3;
    32.14 118.7 0];
marking = [laneMarking('Solid', 'Color', [0 0 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Solid', 'Color', [0 0 0])];
laneSpecification = lanespec(4, 'Width', [3.9625 2.9625 3.6 2.9825], 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

roadCenters = [22.99 118.7 0;
    -49.41 118.7 0];
marking = [laneMarking('Solid', 'Color', [0 0 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Dashed', 'Color', [1 1 0])
    laneMarking('Solid', 'Color', [0 0 0])];
laneSpecification = lanespec(4, 'Width', [3.9625 2.9625 3.6 2.9825], 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);


% Add the ego car
egoCar = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [-20 4.8 0]);
waypoints = [-20 4.8 0;
    -0.8 4.5 0;
    14.38 1.11 0.01;
    20.22 -1.31 0.01;
    28.21 -4.54 0.01;
    33.05 -3.39 0.01;
    36.68 -0.77 0.01;
    39.83 2.72 0.06;
    44.06 3.93 0.08;
    56.05 4.08 0.71;
    94.5 4.5 2.6;
    107.1 7 3;
    110.1 11.1 3;
    111.9 19.9 3;
    111.8 26.8 3;
    112.1 75.8 3];
speed = 20;
trajectory(egoCar, waypoints, speed);

% Add the non-ego actors
actor_vehicle = vehicle(scenario, ...
    'ClassID', 2, ...
    'Length', 8.2, ...
    'Width', 2.5, ...
    'Height', 3.5, ...
    'Position', [28 51.6 0]);
waypoints = [28 51.6 0;
    28 32.2 0;
    28 24.4 0;
    24 15 0;
    22 5.1 0;
    23 -1.8 0;
    26 -8.3 0;
    28 -13.6 0;
    28 -18.4 0;
    28 -23.2 0;
    28 -27.8 0;
    28 -33.8 0;
    28 -38 0;
    27.9 -74 0;
    28.4 -125.1 0];
speed = [20;20;10;8;8;10;10;20;20;10;10;10;10;10;10];
trajectory(actor_vehicle, waypoints, speed);

pedestrian = actor(scenario, ...
    'ClassID', 4, ...
    'Length', 0.24, ...
    'Width', 0.45, ...
    'Height', 1.7, ...
    'Position', [10.84 0.0999999999999996 0], ...
    'RCSPattern', [-8 -8;-8 -8]);
waypoints = [10.84 0.0999999999999996 0;
    10.84 6.1 0;
    10.84 11.9 0;
    10.1 139 0];
speed = [2.8;1.42;1.39;1.39];
trajectory(pedestrian, waypoints, speed);

vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [98.8 8.7 0]);

vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [114.3 -87.1 0], ...
    'Yaw', 90);

car2 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [99.7 6.6 2.9]);
waypoints = [99.7 6.6 2.9;
    59.1 6.8 0.9;
    41.5 9 0.1;
    33.1 14.9 0;
    33.1 29.4 0;
    33.4 57.3 0;
    34 115.5 0.1;
    33.5 130 0];
speed = [5;20;20;20;20;20;2;2];
trajectory(car2, waypoints, speed);

car3 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [114.2 -131.9 3]);
waypoints = [114.2 -131.9 3;
    114.4 0.3 3;
    114.2 124.6 3];
speed = [6;30;30];
trajectory(car3, waypoints, speed);

bicycle = actor(scenario, ...
    'ClassID', 3, ...
    'Length', 1.7, ...
    'Width', 0.45, ...
    'Height', 1.7, ...
    'Position', [15 -1.6 0]);
waypoints = [15 -1.6 0;
    18.22 -4.36 0.01;
    22.06 -6.69 0.01;
    28.31 -7.93 0.01;
    33.8 -6.97 0.01;
    38.75 -3.4 0.01;
    41.29 0.31 0.08;
    41.35 7.31 0.07;
    38.75 14.17 0.01;
    33.9 18.2 0;
    26.3 18.5 0;
    17.2 14.8 0;
    11.1 9.5 0;
    6.1 9.6 0;
    -17.7 11 0];
speed = 5;
trajectory(bicycle, waypoints, speed);

car4 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [104.1 111.8 3]);
waypoints = [104.1 111.8 3;
    104.3 39.8 3;
    104.3 -60.2 3;
    104.7 -122.3 3;
    102.7 -127.7 3;
    98 -130.1 2.8;
    96.1 -130.4 2.7;
    87.6 -128 2.3;
    39.5 -128 0.2];
speed = [5;30;30;30;30;30;30;30;30];
trajectory(car4, waypoints, speed);

%% Adding Sensors
Sensors{1}=Mobileye6('Mobileye6',[egoCar.Wheelbase*.75 egoCar.Width/4 egoCar.Height*.95],[0 0 0],1);
Sensors{2}=Bosch_MRR_Front('Bosch_MRR_Front',[egoCar.Wheelbase+egoCar.FrontOverhang 0 egoCar.Height*.4],[0 0 0],2);
Sensors{3}=Bosch_MRR_Corner('Bosch_MRR_Corner_Left',[0 egoCar.Width/2 egoCar.Height*.4],[0 0 90],3);
Sensors{4}=Bosch_MRR_Corner('Bosch_MRR_Corner_Right',[0 -egoCar.Width/2 egoCar.Height*.4],[0 0 -90],4);
Sensors{5}=Bosch_MRR_Rear('Bosch_MRR_Rear',[-egoCar.RearOverhang 0 egoCar.Height*.4],[0 0 180],5);
Sensors{6}=Velodyne_VLP16('Velodyne_VLP16',[egoCar.Wheelbase*.75 0 egoCar.Height+.05],[0 0 0],6);
%% Sensor Fusion
Tracker=SensorFusion(Sensors,@initcvkf,10,[4 5],5,200,1);
Tracker.InitializePlots();
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
    
end