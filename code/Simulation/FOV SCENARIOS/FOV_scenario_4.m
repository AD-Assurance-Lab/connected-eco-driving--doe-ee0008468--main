clc, clear, close all

%% Generate Sc-enario
scenario = drivingScenario;
scenario.SampleTime = 0.008;
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




% Add the non-ego actors

%% Visualize Scenario

% Add a car plot that follows the ego vehicle from behind
chasePlot(egoCar)
% Add a car plot that follows the ego vehicle from a top view
chasePlot(egoCar,'ViewHeight',200,'ViewLocation',[0 0],'ViewPitch',90)
% Advance simulation

%% Define Radar and Vision Sensors
% Front-facing camera located at front windshield.
sensors{1} = visionDetectionGenerator('SensorIndex',1, 'FalsePositivesPerImage',0.1, ...
    'SensorLocation',[0.75*egoCar.Wheelbase 0], 'Height',1.1, 'DetectorOutput', 'Lanes and objects');

% Front-facing long-range radar sensor at the center of the front bumper of the car.
sensors{2} = radarDetectionGenerator('SensorIndex',2,'Height',0.4,'MaxRange',200, ...
    'SensorLocation',[egoCar.Wheelbase + egoCar.FrontOverhang 0],'FieldOfView',[18 32]);
sensors{3} = radarDetectionGenerator('SensorIndex',3,'Height',0.4,'MaxRange',60, ...
    'SensorLocation',[egoCar.Wheelbase + egoCar.FrontOverhang 0],'FieldOfView',[56 32]);

sensors{4} = radarDetectionGenerator('SensorIndex',4,'Height',0.6, 'Yaw', -180, 'MaxRange', 80, ...
    'SensorLocation', [-(egoCar.RearOverhang) 0],'FieldOfView',[10 25]);
sensors{5} = radarDetectionGenerator('SensorIndex',5, ...
    'SensorLocation', [-egoCar.RearOverhang 0],'Height',0.6, 'Yaw', -180, 'MaxRange', 5,'FieldOfView',[150 72]);

sensors{6} = radarDetectionGenerator('SensorIndex',6,'Height',0.6, 'Yaw', 110, 'MaxRange', 113.12, ...
    'SensorLocation', [-(egoCar.RearOverhang) (egoCar.Width)/2],'FieldOfView',[150 5]);
sensors{7} = radarDetectionGenerator('SensorIndex',7, ...
    'SensorLocation', [-(egoCar.RearOverhang) -(egoCar.Width)/2],'Height',0.6, 'Yaw', -110, 'MaxRange', 113.12,'FieldOfView',[150 5]);


%% Visualize Bird's Eye Plot

% Create bird's eye plotter
bep = birdsEyePlot('XLimits',[-50 100],'YLimits',[-50 50]);

% Create coverage area plotter
cap{1} = coverageAreaPlotter(bep,'FaceColor','blue','EdgeColor','blue');
cap{2} = coverageAreaPlotter(bep,'FaceColor','red','EdgeColor','red');
cap{3} = coverageAreaPlotter(bep,'FaceColor','red','EdgeColor','red');
cap{4} = coverageAreaPlotter(bep,'FaceColor','red','EdgeColor','red');
cap{5} = coverageAreaPlotter(bep,'FaceColor','red','EdgeColor','red');
cap{6} = coverageAreaPlotter(bep,'FaceColor','red','EdgeColor','red');
cap{7} = coverageAreaPlotter(bep,'FaceColor','red','EdgeColor','red');

detPlotter = detectionPlotter(bep,'DisplayName','Object detections');
lmPlotter = laneMarkingPlotter(bep,'DisplayName','Lane markings');
lbPlotter = laneBoundaryPlotter(bep,'DisplayName', 'Lane boundary detections','Color','green');
olPlotter = outlinePlotter(bep);
% Plot coverage area
plotCoverageArea(cap{1},sensors{1}.SensorLocation,sensors{1}.MaxRange,sensors{1}.Yaw,45);
plotCoverageArea(cap{2},sensors{2}.SensorLocation,sensors{2}.MaxRange,sensors{2}.Yaw,sensors{2}.FieldOfView(1));
plotCoverageArea(cap{3},sensors{3}.SensorLocation,sensors{3}.MaxRange,sensors{3}.Yaw,sensors{3}.FieldOfView(1));
plotCoverageArea(cap{4},sensors{4}.SensorLocation,sensors{4}.MaxRange,sensors{4}.Yaw,sensors{4}.FieldOfView(1));
plotCoverageArea(cap{5},sensors{5}.SensorLocation,sensors{5}.MaxRange,sensors{5}.Yaw,sensors{5}.FieldOfView(1));
plotCoverageArea(cap{6},sensors{6}.SensorLocation,sensors{6}.MaxRange,sensors{6}.Yaw,sensors{6}.FieldOfView(1));
plotCoverageArea(cap{7},sensors{7}.SensorLocation,sensors{7}.MaxRange,sensors{7}.Yaw,sensors{7}.FieldOfView(1));

% Create detection plotter
bepPlotters.vision = detectionPlotter(bep,'DisplayName','vision','MarkerEdgeColor','blue','Marker','^');
bepPlotters.radar = detectionPlotter(bep,'DisplayName','radar','MarkerEdgeColor','green','Marker','x');
 
% Create track plotter
bepPlotters.track = trackPlotter(bep,'DisplayName','track','HistoryDepth',10);

%% Create Multi Object Tracker
tracker = multiObjectTracker(...
            'FilterInitializationFcn',@initcvkf, ...
            'AssignmentThreshold',10,'ConfirmationParameters',[4 5], ...
            'NumCoastingUpdates',5);
        
positionSelector = [1 0 0 0; 0 0 1 0];
        
velocitySelector = [0 1 0 0; 0 0 0 1];

%% Simulate Sensor Fusion Algorithm with Scenario
restart(scenario);
while advance(scenario)
    % Get scenario time
    time = scenario.SimulationTime;
    % Get position of other vehicles in ego coordinates
    ta = targetPoses(egoCar);
    [lmv,lmf] = laneMarkingVertices(egoCar);
   plotLaneMarking(lmPlotter,lmv,lmf)
    lookaheadDistance = 0:0.5:200;
    lb = laneBoundaries(egoCar,'XDistance',lookaheadDistance,'LocationType','inner', 'AllBoundaries', true);
    % Simulate sensors
    [sensorDets1,numValidDets1,sensorValid(1),lb_dets,nlb_dets,lbValid] = sensors{1}(ta,lb,time);
    [sensorDets2,numValidDets2,sensorValid(2)] = sensors{2}(ta,time);
    [sensorDets3,numValidDets3,sensorValid(3)] = sensors{3}(ta,time);
    [sensorDets4,numValidDets4,sensorValid(4)] = sensors{4}(ta,time);
    [sensorDets5,numValidDets5,sensorValid(5)] = sensors{5}(ta,time);
    [sensorDets6,numValidDets6,sensorValid(6)] = sensors{6}(ta,time);
    [sensorDets7,numValidDets7,sensorValid(7)] = sensors{7}(ta,time);
   
   
    [objposition,objyaw,objlength,objwidth,objriginOffset,color] = targetOutlines(egoCar);
   plotOutline(olPlotter,objposition,objyaw,objlength,objwidth,'OriginOffset',objriginOffset,'Color', color)
  
    % Edit detections and get detection positions
    for idx = 1:numel(sensorDets1)
        
        % Get positions
        visionPos(idx,:) = sensorDets1{idx}.Measurement(1:2)';
        % Keep only position information
        sensorDets1{idx}.Measurement = sensorDets1{idx}.Measurement(1:2);
        % Edit measurement noise
        sensorDets1{idx}.MeasurementNoise = diag([2,2]);
        % Add NaN SNR to vision detections
        sensorDets1{idx}.ObjectAttributes{1}.SNR = NaN;
        
    end
    
    for idx = 1:numel(sensorDets2)
        
        % Get positions
        radarPos(idx,:) = sensorDets2{idx}.Measurement(1:2)';
        % Keep only position information
        sensorDets2{idx}.Measurement = sensorDets2{idx}.Measurement(1:2);
        % Edit measurement noise
        sensorDets2{idx}.MeasurementNoise = diag([100,100]);
        
    end
    
    for idx = 1:numel(sensorDets3)
        
        % Get positions
        radarPos(idx,:) = sensorDets3{idx}.Measurement(1:2)';
        % Keep only position information
        sensorDets3{idx}.Measurement = sensorDets3{idx}.Measurement(1:2);
        % Edit measurement noise
        sensorDets3{idx}.MeasurementNoise = diag([100,100]);
        
    end
    
    for idx = 1:numel(sensorDets4)
        
        % Get positions
        radarPos(idx,:) = sensorDets4{idx}.Measurement(1:2)';
        % Keep only position information
        sensorDets4{idx}.Measurement = sensorDets4{idx}.Measurement(1:2);
        % Edit measurement noise
        sensorDets4{idx}.MeasurementNoise = diag([100,100]);
        
    end
    
    for idx = 1:numel(sensorDets5)
        
        % Get positions
        radarPos(idx,:) = sensorDets5{idx}.Measurement(1:2)';
        % Keep only position information
        sensorDets5{idx}.Measurement = sensorDets5{idx}.Measurement(1:2);
        % Edit measurement noise
        sensorDets5{idx}.MeasurementNoise = diag([100,100]);
        
    end
    
    for idx = 1:numel(sensorDets6)
        
        % Get positions
        radarPos(idx,:) = sensorDets6{idx}.Measurement(1:2)';
        % Keep only position information
        sensorDets6{idx}.Measurement = sensorDets6{idx}.Measurement(1:2);
        % Edit measurement noise
        sensorDets6{idx}.MeasurementNoise = diag([100,100]);
        
    end
    
    for idx = 1:numel(sensorDets7)
        
        % Get positions
        radarPos(idx,:) = sensorDets7{idx}.Measurement(1:2)';
        % Keep only position information
        sensorDets7{idx}.Measurement = sensorDets7{idx}.Measurement(1:2);
        % Edit measurement noise
        sensorDets7{idx}.MeasurementNoise = diag([100,100]);
        
    end
    
     
    
    % Plot detections
    if(numel(sensorDets1))
    plotDetection(bepPlotters.vision,visionPos);
    end
    
    if(numel(sensorDets2))
    plotDetection(bepPlotters.radar,radarPos);
    end
    
    if(numel(sensorDets3))
    plotDetection(bepPlotters.radar,radarPos);
    end
    
    if(numel(sensorDets4))
    plotDetection(bepPlotters.radar,radarPos);
    end
    
    if(numel(sensorDets5))
    plotDetection(bepPlotters.radar,radarPos);
    end
    
    if(numel(sensorDets6))
    plotDetection(bepPlotters.radar,radarPos);
    end
    
    if(numel(sensorDets7))
    plotDetection(bepPlotters.radar,radarPos);
    end
    
  
    if lbValid
        plotLaneBoundary(lbPlotter,vertcat(lb_dets.LaneBoundaries))
    end
    % Create object detection report
    detections = [sensorDets1;sensorDets2;sensorDets3;sensorDets4;sensorDets5;sensorDets6;sensorDets7];
    
    % Update and visualize tracks
    if (any([sensorValid(1) sensorValid(2) sensorValid(3) sensorValid(4) sensorValid(5) sensorValid(6) sensorValid(7)]))
        confirmedTracks = updateTracks(tracker,detections,time);
        trackIDs = {confirmedTracks.TrackID};
        trackLabels = cellfun(@num2str, trackIDs, 'UniformOutput', false);
%         if numel(confirmedTracks)>=1
%             return
%         end
        [trackPositions,trackCovariances] = getTrackPositions(confirmedTracks,positionSelector);
        trackVelocities = getTrackVelocities(confirmedTracks,velocitySelector);
        plotTrack(bepPlotters.track,trackPositions,trackVelocities,trackCovariances,trackLabels);
        
    end
    
end