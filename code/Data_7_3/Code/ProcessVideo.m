function [detections,positions] = ProcessVideo(detections, visionFrame, time)
% Process the video objects into objectDetection objects
numImputObjects = numel(detections);
numVisionObjects = visionFrame.numObjects;
positions=zeros(numVisionObjects,2);
if numVisionObjects
    classToUse = class(visionFrame.object(1).position);
    visionMeasCov = cast(diag([2,2,2,100]), classToUse);
    % Process Vision Objects:
    for i=1:numVisionObjects
        object = visionFrame.object(i);
        detections{numImputObjects+i} = objectDetection(time,...
            [object.position(1); object.velocity(1); object.position(2); 0], ...
            'SensorIndex', 1, 'MeasurementNoise', visionMeasCov, ...
            'MeasurementParameters', {1}, ...
            'ObjectClassID', object.classification, ...
            'ObjectAttributes', {object.id, object.size});
        positions(i,:)=[object.position(1); object.position(2);];
    end
end
end