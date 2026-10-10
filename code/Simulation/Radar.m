classdef Radar<handle
    properties
        Name
        Sensor
        Data
        Location %[x,y,z] x,y in veh coord z in ref to ground (VS - TCS)
        Orientation %[i,j,k] (roll,pitch,yaw) veh (VS - VCS)
        FieldOfView
        Range
    end
    methods
        function obj=Radar(Name,Location,Orientation,FieldOfView,Range)
            if nargin>0
                obj.Name=Name;
                obj.Location=Location;
                obj.Orientation=Orientation;
                obj.FieldOfView=FieldOfView;
                obj.Range=Range;
            else
                obj.Name='Radar';
                obj.Location=[0 0 1];
                obj.Orientation=[0 0 0];
                obj.FieldOfView=[56 32];
                obj.Range=60;
            end
            obj.Initialize();
        end
        function obj=Detections(obj,TP,LB,time,index)
            [ObjDets]=obj.Sensor(TP,LB,time);
            for i = 1:1:numel(ObjDets)
                obj.Data.(sprintf('%s_obj%i_%s',obj.Name,i,'dx'))(index)=ObjDets{i}.Measurement(1);
                obj.Data.(sprintf('%s_obj%i_%s',obj.Name,i,'dy'))(index)=ObjDets{i}.Measurement(2);
                obj.Data.(sprintf('%s_obj%i_%s',obj.Name,i,'vx'))(index)=ObjDets{i}.Measurement(3);
                obj.Data.(sprintf('%s_obj%i_%s',obj.Name,i,'vy'))(index)=ObjDets{i}.Measurement(4);
                obj.Data.(sprintf('%s_obj%i_%s',obj.Name,i,'ax'))(index)=ObjDets{i}.Measurement(5);
                obj.Data.(sprintf('%s_obj%i_%s',obj.Name,i,'ay'))(index)=ObjDets{i}.Measurement(6); 
            end
        end
        function obj=Initialize(obj)
            obj.Sensor=radarDetectionGenerator();
            obj.Sensor.SensorIndex=2;                %Unique identifier of sensor
            obj.Sensor.UpdateInterval=.05;             %Required interval between sensor updates
            obj.Sensor.SensorLocation=[obj.Location(1) obj.Location(2)];          %Location of sensor center specified in
                                                 %vehicle coordinate system
            obj.Sensor.Height=obj.Location(3);                     %Sensor's mounting height from the ground
            obj.Sensor.Yaw=obj.Orientation(3);                        %Yaw angle of sensor mounted on ego
                                                 %vehicle
            obj.Sensor.Pitch=obj.Orientation(2);                      %Pitch angle of sensor mounted on ego
                                                 %vehicle
            obj.Sensor.Roll=obj.Orientation(1);                       %Roll angle of sensor mounted on ego
                                       %vehicle
            obj.Sensor.FieldOfView=obj.FieldOfView;                %Total angular field of view for radar
            obj.Sensor.MaxRange=obj.Range;                   %Maximum detection range
            % obj.Sensor.RangeRateLimits            %Minimum and maximum range rates that can
                                       %be reported
            % obj.Sensor.DetectionProbability       %Detection probability
            % obj.Sensor.FalseAlarmRate             %Rate at which false alarms are reported
            % obj.Sensor.ReferenceRange             %Range where detection probability is
                                       %achieved
            % obj.Sensor.ReferenceRCS               %Target's radar cross section (RCS) at
                                       %which detection probability is achieved
            % obj.Sensor.RadarLoopGain              %Loop gain of radar (read-only)
            % obj.Sensor.AzimuthResolution          %Azimuthal resolution of radar
            % obj.Sensor.ElevationResolution        %Elevation resolution of radar
            % obj.Sensor.RangeResolution            %Range resolution of radar
            % obj.Sensor.RangeRateResolution        %Range rate resolution of radar
            % obj.Sensor.AzimuthBiasFraction        %Fractional azimuthal bias component of 
                                       %radar
            % obj.Sensor.ElevationBiasFraction      %Fractional elevation bias component of
                                       %radar
            % obj.Sensor.RangeBiasFraction          %Fractional range bias component of radar
            % obj.Sensor.RangeRateBiasFraction      %Fractional range rate bias component of
                                       %radar
            % obj.Sensor.HasElevation               %Enable elevation angle measurements
            % obj.Sensor.HasRangeRate               %Enable range rate measurements
            % obj.Sensor.HasNoise                   %Add noise to measurements
            % obj.Sensor.HasFalseAlarms             %Enable false detections
            % obj.Sensor.HasOcclusion               %Enable line-of-sight occlusion
            obj.Sensor.MaxNumDetectionsSource='Property';     %Source of maximum number of detections
            obj.Sensor.MaxNumDetections=32;           %Maximum number of reported detections
            % obj.Sensor.DetectionCoordinates       %Coordinate system used to report detections
            % obj.Sensor.ActorProfiles              %Profiles for all actors used to generate
            obj.Data=struct('empty',[]);
            NMessages=obj.Sensor.MaxNumDetections;
            SignalNames={'dx','dy','vx','vy','ax','ay'};
            for i=1:1:NMessages
                for j=1:1:numel(SignalNames)
                    c=SignalNames(j); s=c{:};
                    obj.Data.(sprintf('%s_obj%i_%s',obj.Name,i,s))=[];
                end
            end
        end
    end
end