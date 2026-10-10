function [DataOut]=SensorFusion_InterpolatedData(InterpolatedData)
%Converting radar and mobileye data into a form which can be used by the
%sensor fusion
fprintf('Converting ...\n')
rad=RadarToASDT(InterpolatedData);
vis=MobileyeToASDT(InterpolatedData);
%Creating the sensor fusion object
tracker = multiObjectTracker(...
    'FilterInitializationFcn', @initConstantAccelerationFilter, ...
    'AssignmentThreshold', 35, 'ConfirmationParameters', [2 3], ...
    'NumCoastingUpdates', 5);

index=0;
DataOut=struct('detections',{},'tracks',{});
fprintf('Begin Loop ...\n')
for i=1:1:numel(InterpolatedData.time)
    % Update scenario counters
    index=index+1;
    time = InterpolatedData.time(index);
    
    % Process the sensor detections as objectDetection inputs to the tracker
    detections={};
    if ~isnan(rad(index).object(1).status)
        [detections,~]=ProcessRadar(detections,rad(index),time);
        [detections,~]=ProcessVideo(detections,vis(index),time);
    end

    % Using the list of objectDetections, return the tracks, updated to time
    [ConfirmedTracks,~]=tracker(detections,time);
    
    %Assign data
    DataOut(i).detections=detections;
    DataOut(i).tracks=ConfirmedTracks;
    if rem(index,1000)==0
        fprintf('Processing Index %i, %i current tracks ...\n',index,numel(ConfirmedTracks))
    end
end