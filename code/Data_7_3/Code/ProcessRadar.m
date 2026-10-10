function [detections,positions] = ProcessRadar(detections, radarFrame, time)
% Process the radar objects into objectDetection objects
numRadarObjects = radarFrame.numObjects;
positions=zeros(numRadarObjects,2);
if numRadarObjects
    classToUse = class(radarFrame.object(1).position);
    radarMeasCov = cast(diag([2,2,2,100]), classToUse);
    % Process Radar Objects:
    for i=1:numRadarObjects
        object = radarFrame.object(i);
        detections{i} = objectDetection(time, ...
            [object.position(1); object.velocity(1); object.position(2); object.velocity(2)], ...
            'SensorIndex', 2, 'MeasurementNoise', radarMeasCov, ...
            'MeasurementParameters', {2}, ...
            'ObjectAttributes', {object.id, object.status, object.amplitude, object.rangeMode});
        positions(i,:)=[object.position(1); object.position(2);];
    end
end
end