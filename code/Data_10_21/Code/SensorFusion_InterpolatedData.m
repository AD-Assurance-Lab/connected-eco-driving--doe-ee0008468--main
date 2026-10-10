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
nIndices=numel(InterpolatedData.time);
tic
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
        timeElapsed=toc;
        percentDone=index/nIndices;
        ert=timeElapsed/percentDone-timeElapsed;
        fprintf('Processing Index %i of %i, %i current tracks, %.2f seconds elapsed, estimated %.2f seconds remaining ...\n',index,nIndices,numel(ConfirmedTracks),timeElapsed,ert)
    end
end