%% Generate Sc-enario
clc, clear, close all
scenario = drivingScenario;
scenario.SampleTime = 0.008;
% Define straight road
roadCenters = [-25.93 38.81 0;
    -9.99 36.97 -0.8;
    5.2 24.4 1.5;
    29.7 19 3;
    44.1 26.1 4.5;
    52.7 24.2 4;
    59 14.1 4.5;
    58.2 0.9 3;
    54.3 -15.3 0;
    75.8 -45.7 0];
bankAngle = 5;
marking = [laneMarking('Solid', 'Color', [1 1 0])
    laneMarking('DoubleSolid')
    laneMarking('DoubleSolid', 'Color', [1 1 0])
    laneMarking('DoubleSolid')
    laneMarking('Solid', 'Color', [1 1 0])];
laneSpecification = lanespec(4, 'Width', [1.2 3.6 3.6 1.2], 'Marking', marking);
road(scenario, roadCenters, bankAngle, 'Lanes', laneSpecification);



% Add the non-ego actors
egoCar = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [-24.7 36.9 0.2]);
waypoints = [-24.7 36.9 0.2;
    -15.8 37.2 0.1;
    -9.4 35.4 0.1;
    -5.6 32.5 0.6;
    1.1 25.9 1.8;
    6.7 21.2 2.3;
    12.6 18.5 2.5;
    19 16.7 2.7;
    24.7 15.8 2.8;
    30.8 17.4 3.2;
    34.7 19.8 3.4;
    41.3 23.4 4;
    47.4 24.5 4.1;
    54.3 20.5 4.3;
    57.6 13.4 4.6;
    57.7 6 3.9;
    55.4 -3.4 2.2;
    52.8 -10.8 0.5;
    53 -21.1 0.2;
    56.8 -28.7 0.1;
    61.4 -35.8 0.2;
    66.6 -40.5 0.1;
    69.9 -43.4 0.2];
speed = [18;18;18;18;18;18;18;18;10;0;10;18;18;18;18;18;18;18;18;18;18;18;18];
trajectory(egoCar, waypoints, speed);

% Add the non-ego actors
schoolBus = vehicle(scenario, ...
    'ClassID', 2, ...
    'Length', 8.2, ...
    'Width', 2.5, ...
    'Height', 3.5, ...
    'Position', [-16.8 36.8 -0.5]);
waypoints = [-16.8 36.8 -0.5;
    -8.5 33.4 0.3;
    -0.399999999999999 27.2 1.3;
    3.9 23 2;
    9.8 19.5 2.4;
    16.9 16.7 2.7;
    24.8 15.7 2.9;
    31.8 17.4 3.3;
    37.65 21.12 4.07;
    44.4 24.1 4.1;
    49.52 23.07 4.37;
    54.62 19.34 4.36;
    57.5 13.9 4.6;
    57.7 5.2 3.9;
    55.6 -1.6 2.7;
    53.5 -8.5 0.9;
    52.6 -17.1 0.1;
    54.6 -25.5 0.2;
    58 -31.7 0.1;
    62.5 -36.9 0.2;
    66.5 -40.7 0.2;
    69.9 -43.6 0.1;
    73.2 -46.4 0.2];
speed = [20;20;20;20;20;20;20;15;10;0;10;15;20;20;20;20;20;20;20;20;20;20;20];
trajectory(schoolBus, waypoints, speed);

car1 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [68 -37.1 -0.1]);
waypoints = [68 -37.1 -0.1;
    63.6 -32.6 -0.1;
    59.2 -26.9 -0.1;
    56.9 -20.8 -0.1;
    56.2 -14.8 -0.1;
    57.4 -6.9 1.4;
    60.3 2 3;
    61.3 11.2 4.3;
    59.5 19.4 4.1;
    55.4 24.5 3.9;
    48.7 28.4 4.1;
    41.6 28.1 4.2;
    34.2 24 3.5;
    28.1 21 2.7;
    21.3 19.9 2.4;
    14.7 20.8 2;
    9 23.8 1.6;
    3 28.7 0.7;
    -3.5 35.3 -0.5;
    -10.2 39.4 -1;
    -17.6 40.7 -0.8];
speed = 30;
trajectory(car1, waypoints, speed);

pedestrian = actor(scenario, ...
    'ClassID', 4, ...
    'Length', 0.24, ...
    'Width', 0.45, ...
    'Height', 1.7, ...
    'Position', [51.02 19.71 4.43], ...
    'RCSPattern', [-8 -8;-8 -8]);
waypoints = [51.02 19.71 4.43;
    54.21 23.25 4.02;
    57.26 26.43 3.65];
speed = 1;
trajectory(pedestrian, waypoints, speed);

car2 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [78.9 -44.5 0]);
waypoints = [78.9 -44.5 0;
    62.7 -31.9 -0.1;
    58.2 -25.1 -0.1;
    56.4 -16.8 -0.2;
    56.8 -11 0.2;
    58.9 -3.4 1.9;
    61.1 5 3.6;
    61.2 15.2 4.3;
    56.4 23.6 3.9;
    52.2 27 3.9;
    44.4 28.3 4.3;
    38.2 26.1 4;
    31.9 22.2 3.3;
    25.9 19.9 2.6;
    19.7 20.1 2.3;
    13.4 21.8 1.9;
    7.2 25.6 1.4;
    0.5 31.1 0.4;
    -4.3 35.9 -0.7;
    -10.7 39.2 -0.9;
    -16.4 40.8 -0.8;
    -23.3 41.1 -0.5];
speed = 30;
trajectory(car2, waypoints, speed);

bicycle = actor(scenario, ...
    'ClassID', 3, ...
    'Length', 1.7, ...
    'Width', 0.45, ...
    'Height', 1.7, ...
    'Position', [-8.45 31.13 -0.18]);
waypoints = [-8.45 31.13 -0.18;
    -6.4 29.5 0.3;
    1.7 21.6 1.7;
    10.4 16.2 2.4;
    15.7 14.4 2.6;
    23.7 13.5 3;
    29.9 14.5 3.3;
    35.7 17.2 3.8;
    43 21.3 4.8;
    46.5 21.9 4.8;
    50.8 20.5 4.4;
    54 16.4 4.7;
    55 11.9 4.8;
    55 6 4.1;
    54.1 2.5 3.5;
    53.3 -0.7 2.8;
    51.5 -6.2 1.5;
    50.3 -12 0.5;
    50 -17.3 0.3;
    51 -22.6 0.3;
    52.4 -26.5 0.3;
    54.8 -31.1 0.3;
    57.3 -34.5 0.3;
    60.6 -38 0.3;
    64.8 -42.1 0.3;
    68.8 -45.5 0.3;
    71.4 -47.8 0.4];
speed = 5;
trajectory(bicycle, waypoints, speed);

bicycle1 = actor(scenario, ...
    'ClassID', 3, ...
    'Length', 1.7, ...
    'Width', 0.45, ...
    'Height', 1.7, ...
    'Position', [62.9 -25.97 0]);
waypoints = [62.9 -25.97 0;
    60.07 -22.67 -0.34;
    58.71 -18.05 -0.33;
    58.92 -12.55 -0.05;
    60.23 -7.26 1.19;
    61.64 -2.49 2.23;
    62.43 -0.14 2.6;
    63.63 7.46 3.7;
    63.16 15.16 4.17;
    60.75 21.61 3.97;
    57.71 25.59 3.77;
    52.58 29.31 3.71;
    45.45 30.46 4.15;
    39.16 29.1 4.01;
    34.4 26.53 3.57;
    30.73 24.28 3.03;
    26.33 22.45 2.51;
    21.4 22.08 2.16;
    15.69 23.23 1.81;
    11.55 25.22 1.5;
    6.99 28.58 1.04;
    0.44 34.86 -0.32;
    -6.32 40.26 -1.14;
    -13.34 42.62 -1.11;
    -19.1 43.04 -0.9];
speed = 5;
trajectory(bicycle1, waypoints, speed);


%% Visualize Scenario

% Add a car plot that follows the ego vehicle from behind

%----- Fill -----%
chasePlot(egoCar)
% Add a car plot that follows the ego vehicle from a top view

%----- Fill -----%
chasePlot(egoCar,'ViewHeight',200,'ViewLocation',[0 0],'ViewPitch',90)
% Advance simulation

%----- Fill -----%

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
rflag = 0;
while advance(scenario)
    rflag = rflag +1;
    disp(rflag);
    % Get scenario time
    time = scenario.SimulationTime;
    disp('simtime');
    % Get position of other vehicles in ego coordinates
    ta = targetPoses(egoCar);
    [lmv,lmf] = laneMarkingVertices(egoCar);
   plotLaneMarking(lmPlotter,lmv,lmf)
    lookaheadDistance = 0:0.5:200;
    lb = laneBoundaries(egoCar,'XDistance',lookaheadDistance,'LocationType','inner', 'AllBoundaries', true);
    disp('simpos');
    % Simulate sensors
    [sensorDets1,numValidDets1,sensorValid(1),lb_dets,nlb_dets,lbValid] = sensors{1}(ta,lb,time);
    disp('thischunckvis');
    [sensorDets2,numValidDets2,sensorValid(2)] = sensors{2}(ta,time);
    disp('thischunck2');
    [sensorDets3,numValidDets3,sensorValid(3)] = sensors{3}(ta,time);
    disp('thischunck3');
    [sensorDets4,numValidDets4,sensorValid(4)] = sensors{4}(ta,time);
    disp('thischunck4');
    [sensorDets5,numValidDets5,sensorValid(5)] = sensors{5}(ta,time);
    disp('thischunck5');
    [sensorDets6,numValidDets6,sensorValid(6)] = sensors{6}(ta,time);
    disp('thischunck6');
    [sensorDets7,numValidDets7,sensorValid(7)] = sensors{7}(ta,time);
    disp('thischunck7');
  
    [objposition,objyaw,objlength,objwidth,objriginOffset,color] = targetOutlines(egoCar);
   plotOutline(olPlotter,objposition,objyaw,objlength,objwidth,'OriginOffset',objriginOffset,'Color', color)
  
   disp('initialization');
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
    
     
  
    disp('before plot detections');
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
    disp('after detection');
    % Create object detection report
    detections = [sensorDets1;sensorDets2;sensorDets3;sensorDets4;sensorDets5;sensorDets6;sensorDets7];
    
    % Update and visualize tracks
    if (any([sensorValid(1) sensorValid(2) sensorValid(3) sensorValid(4) sensorValid(5) sensorValid(6) sensorValid(7)]))
        disp('updating tracks');
        confirmedTracks = updateTracks(tracker,detections,time);
        trackIDs = {confirmedTracks.TrackID};
        trackLabels = cellfun(@num2str, trackIDs, 'UniformOutput', false);
        [trackPositions,trackCovariances] = getTrackPositions(confirmedTracks,positionSelector);
        trackVelocities = getTrackVelocities(confirmedTracks,velocitySelector);
        plotTrack(bepPlotters.track,trackPositions,trackVelocities,trackCovariances,trackLabels);
        
    end
    
end
disp('Out of while');