%% Generate Sc-enario
clc, clear, close all

scenario = drivingScenario;
scenario.SampleTime = 0.008;
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
            'AssignmentThreshold',8,'ConfirmationParameters',[2 3], ...
            'NumCoastingUpdates',3);
        
positionSelector = [1 0 0 0; 0 0 1 0];
        
velocitySelector = [0 1 0 0; 0 0 0 1];

%% Simulate Sensor Fusion Algorithm with Scenario
restart(scenario);
rflag = 0;
while advance(scenario)
    rflag = rflag +1;
    %disp(rflag);
    % Get scenario time
    time = scenario.SimulationTime;
    %disp('simtime');
    % Get position of other vehicles in ego coordinates
    ta = targetPoses(egoCar);
    [lmv,lmf] = laneMarkingVertices(egoCar);
   plotLaneMarking(lmPlotter,lmv,lmf)
    lookaheadDistance = 0:0.5:200;
    lb = laneBoundaries(egoCar,'XDistance',lookaheadDistance,'LocationType','inner', 'AllBoundaries', true);
    %disp('simpos');
    % Simulate sensors
    [sensorDets1,numValidDets1,sensorValid(1),lb_dets,nlb_dets,lbValid] = sensors{1}(ta,lb,time);
    %disp('thischunckvis');
    [sensorDets2,numValidDets2,sensorValid(2)] = sensors{2}(ta,time);
    %disp('thischunck2');
    [sensorDets3,numValidDets3,sensorValid(3)] = sensors{3}(ta,time);
    %disp('thischunck3');
    [sensorDets4,numValidDets4,sensorValid(4)] = sensors{4}(ta,time);
    %disp('thischunck4');
    [sensorDets5,numValidDets5,sensorValid(5)] = sensors{5}(ta,time);
    %disp('thischunck5');
    [sensorDets6,numValidDets6,sensorValid(6)] = sensors{6}(ta,time);
    %disp('thischunck6');
    [sensorDets7,numValidDets7,sensorValid(7)] = sensors{7}(ta,time);
    %disp('thischunck7');
   
   
    [objposition,objyaw,objlength,objwidth,objriginOffset,color] = targetOutlines(egoCar);
   plotOutline(olPlotter,objposition,objyaw,objlength,objwidth,'OriginOffset',objriginOffset,'Color', color)
  
   %disp('initialization');
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
    
     
   
    %disp('before plot detections');
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
    %disp('after detection');
    % Create object detection report
    detections = [sensorDets1;sensorDets2;sensorDets3;sensorDets4;sensorDets5;sensorDets6;sensorDets7];
    
    % Update and visualize tracks
    if (any([sensorValid(1) sensorValid(2) sensorValid(3) sensorValid(4) sensorValid(5) sensorValid(6) sensorValid(7)]))
        %disp('updating tracks');
        confirmedTracks = updateTracks(tracker,detections,time);
        trackIDs = {confirmedTracks.TrackID};
        trackLabels = cellfun(@num2str, trackIDs, 'UniformOutput', false);
        [trackPositions,trackCovariances] = getTrackPositions(confirmedTracks,positionSelector);
        trackVelocities = getTrackVelocities(confirmedTracks,velocitySelector);
        plotTrack(bepPlotters.track,trackPositions,trackVelocities,trackCovariances,trackLabels);
        disp("rflag");
        disp(rflag);
        disp("fusion result");
        disp(trackPositions);
        disp("ground truth");
        disp(ta(1).Position);
        disp(ta(2).Position);
        disp(ta(3).Position);
        
    end
    
end
disp('Out of while');