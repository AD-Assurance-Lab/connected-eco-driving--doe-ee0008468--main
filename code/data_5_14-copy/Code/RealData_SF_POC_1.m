load('InterpolatedData_10Hz.mat');
rad=RadarToASDT(InterpolatedData);
vis=MobileyeToASDT(InterpolatedData);
numSteps=numel(vis);

tracker = multiObjectTracker(...
    'FilterInitializationFcn', @initConstantAccelerationFilter, ...
    'AssignmentThreshold', 35, 'ConfirmationParameters', [2 3], ...
    'NumCoastingUpdates', 5);

% The State vector is:
%   In constant velocity:     State = [x;vx;y;vy]
%   In constant acceleration: State = [x;vx;ax;y;vy;ay]

% Define which part of the State is the position. For example:
%   In constant velocity:     [x;y] = [1 0 0 0; 0 0 1 0] * State
%   In constant acceleration: [x;y] = [1 0 0 0 0 0; 0 0 0 1 0 0] * State
PositionSelector = [1 0 0 0 0 0; 0 0 0 1 0 0];

% Define which part of the State is the velocity. For example:
%   In constant velocity:     [x;y] = [0 1 0 0; 0 0 0 1] * State
%   In constant acceleration: [x;y] = [0 1 0 0 0 0; 0 0 0 0 1 0] * State
VelocitySelector = [0 1 0 0 0 0; 0 0 0 0 1 0];
%% Initializing Plotters
BEP=birdsEyePlot('XLimits',[0 120],'YLimits',[-40 40]);
Plots.VP = detectionPlotter(BEP,'DisplayName','Vision','MarkerEdgeColor','b');
Plots.RP = detectionPlotter(BEP,'DisplayName','Radar','MarkerEdgeColor','r','Marker','x');
Plots.TP = trackPlotter(BEP,'DisplayName','Track','HistoryDepth',10,'MarkerEdgeColor','k','Marker','s');
%%
index=5731;
for i=1:1:numSteps
    % Update scenario counters
    index=index+1;
    time = InterpolatedData.time(index);
%     disp([time index])
    
    % Process the sensor detections as objectDetection inputs to the tracker
    detections={};
    if ~isnan(rad(index).object(1).status)
        [detections,RadarPositions]=ProcessRadar(detections,rad(index),time);
        [detections,VisualPositions]=ProcessVideo(detections,vis(index),time);
    end
    
    
    % Using the list of objectDetections, return the tracks, updated to time
    [ConfirmedTracks,TentativeTracks]=tracker(detections,time);
    disp(numel(ConfirmedTracks))
    TrackPositions = getTrackPositions(ConfirmedTracks,PositionSelector);
    TrackVelocities = getTrackVelocities(ConfirmedTracks,VelocitySelector);
    if numel(RadarPositions)>0
        plotDetection(Plots.RP,RadarPositions);
    end
    if numel(VisualPositions)>0
        plotDetection(Plots.VP,VisualPositions);
    end
    if numel(TrackPositions)>0
        plotTrack(Plots.TP,TrackPositions,TrackVelocities);
    end
end