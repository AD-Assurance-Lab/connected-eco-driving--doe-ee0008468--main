%% Generate Sc-enario
clc, clear, close all

scenario = drivingScenario;
scenario.SampleTime = 0.008;
% Add all road segments
roadCenters = [100 -0.08 0;
    1.81 -0.15 0];
laneSpecification = lanespec(5, 'Width', 3);
road(scenario, roadCenters, 'Lanes', laneSpecification);

% Add the ego car
egoCar = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [15.2 -0.23 0.01]);
waypoints = [15.2 -0.23 0.01;
    100 -0.08 0.01];
speed = 10;
trajectory(egoCar, waypoints, speed);

% Add the non-ego actors
car1 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [25.38 2.94 0.01]);
waypoints = [25.38 2.94 0.01;
    100 2.79 0.01];
speed = 10;
trajectory(car1, waypoints, speed);

car2 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [19.72 2.87 0.01]);
waypoints = [19.72 2.87 0.01;
    100 2.64 0.01];
speed = 10;
trajectory(car2, waypoints, speed);

car3 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [32.84 2.87 0.01]);
waypoints = [32.84 2.87 0.01;
    100 2.94 0.01];
speed = 10;
trajectory(car3, waypoints, speed);

car4 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [13.16 2.56 0.01]);
waypoints = [13.16 2.56 0.01;
    100 2.71 0.01];
speed = 10;
trajectory(car4, waypoints, speed);

car5 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [22.44 -0.08 0.01]);
waypoints = [22.44 -0.08 0.01;
    100 -0.23 0.01];
speed = 10;
trajectory(car5, waypoints, speed);

car6 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [30.73 -0.15 0.01]);
waypoints = [30.73 -0.15 0.01;
    100 -0.23 0.01];
speed = 10;
trajectory(car6, waypoints, speed);

car7 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [20.35 -3.21 0.01]);
waypoints = [20.35 -3.21 0.01;
    100.4 -2.8 0];
speed = 10;
trajectory(car7, waypoints, speed);

car8 = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [28.4 -3.3 0]);
waypoints = [28.4 -3.3 0;
    99.5 -2.7 0];
speed = 10;
trajectory(car8, waypoints, speed);



%% Visualize Scenario

% Add a car plot that follows the ego vehicle from behind
chasePlot(egoCar)
% Add a car plot that follows the ego vehicle from a top view
chasePlot(egoCar,'ViewHeight',200,'ViewLocation',[0 0],'ViewPitch',90)
% Advance simulation
%% Define Radar and Vision Sensors
% Front-facing camera located at front windshield.
sensors{1} = visionDetectionGenerator('SensorIndex',1, 'FalsePositivesPerImage',0.1, ...
    'SensorLocation',[0.75*egoCar.Wheelbase 0], 'Height',1.3, 'DetectorOutput', 'Lanes and objects');

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
bep = birdsEyePlot('XLimits',[-20 40],'YLimits',[-20 20]);

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