%% Real Data Tracking with Sensor Fusion POC
clc; clear all; close all;
%% Load Data
load('InterpolatedData_10Hz.mat');
%% Data Indices
SensorData=struct('name','','DXIndices',[],'DYIndices',[]);
SensorData(1).name='radar';
j=0;
for i=1:1:numel(InterpolatedData.data)
    if regexp(InterpolatedData.data(i).name,'ADAS')
        if regexp(InterpolatedData.data(i).name,'Radar1_Obj')
            if regexp(InterpolatedData.data(i).name(end-2:end),'_dx')
                j=j+1;
                SensorData(1).DXIndices(j)=i;
            end
        end
    end
end
SensorData(1).DYIndices=SensorData(1).DXIndices-1;
SensorData(2).name='mobileye';
j=0;
for i=1:1:numel(InterpolatedData.data)
    if regexp(InterpolatedData.data(i).name,'ADAS')
        if regexp(InterpolatedData.data(i).name,'Obstacle_Pos_X')
            j=j+1;
            SensorData(2).DXIndices(j)=i;
        end
    end
end
SensorData(2).DYIndices=SensorData(2).DXIndices-1;
%% Data to Useable Form

%% Sensor Fusion Initialization
Sensors{1}=Mobileye6('Mobileye6',[egoCar.Wheelbase*.75 egoCar.Width/4 egoCar.Height*.95],[0 0 0],1);
Sensors{2}=Bosch_MRR_Front('Bosch_MRR_Front',[egoCar.Wheelbase+egoCar.FrontOverhang 0 egoCar.Height*.4],[0 0 0],[2 3]);
Tracker=SensorFusion(Sensors,@initcvkf,7,[6 10],2,200,2);
%% Initializing Plotters
BEP=birdsEyePlot();
Plots.VP = detectionPlotter(BEP,'DisplayName','Vision','MarkerEdgeColor','b');
Plots.RP = detectionPlotter(BEP,'DisplayName','Radar','MarkerEdgeColor','r','Marker','x');
Plots.TP = trackPlotter(BEP,'DisplayName','Track','HistoryDepth',10,'MarkerEdgeColor','r','Marker','s');
%% Sensor Fusion Loop
data=struct('detections',{},'Tracks',[]);
mp={struct('Frame',1,'OriginPosition',[0,0,0],'Orientation',[1,0,0;0,1,0;0,0,1],'HasElevation',0,'HasVelocity',1)};
oa={struct('TargetIndex',1,'SNR',NaN)};
for i=1:1:numel(InterpolatedData.data(1).data)
    time=InterpolatedData.time(i);
    disp([i time])
    detections={};
    k=0;
    %Radar
    RadarPositions=[];
    for j=1:1:numel(SensorData(1).DXIndices)
        dxdy=[InterpolatedData.data(SensorData(1).DXIndices(j)).data(i),...
            InterpolatedData.data(SensorData(1).DYIndices(j)).data(i)];
        if ~isnan(dxdy(1))
            k=k+1;
            detections{k,1}=objectDetection(time,dxdy);
            detections{k,1}.MeasurementNoise=diag([100,100]);
            detections{k,1}.SensorIndex=1;
            detections{k,1}.ObjectClassID=0;
            detections{k,1}.MeasurementParameters=mp;
            detections{k,1}.ObjectAttributes=oa;
            
%             detections{k}=objectDetection('Measurement',dxdy,...
%                 'MeasurementNoise',diag([100,100]),'SensorIndex',1,...
%                 'ObjectClassID',0,'Time',time);
            RadarPositions(j,:)=dxdy;
        end
    end
    %Mobileye
    VisualPositions=[];
    for j=1:1:numel(SensorData(2).DXIndices)
        dxdy=[InterpolatedData.data(SensorData(2).DXIndices(j)).data(i),...
            InterpolatedData.data(SensorData(2).DYIndices(j)).data(i)];
        if ~isnan(dxdy(1))
            k=k+1;
            detections{k,1}=objectDetection(time,dxdy);
            detections{k,1}.MeasurementNoise=diag([100,100]);
            detections{k,1}.SensorIndex=2;
            detections{k,1}.ObjectClassID=0;
            detections{k,1}.ObjectAttributes{1}.SNR=NaN;
            detections{k,1}.MeasurementParameters=mp;
            detections{k,1}.ObjectAttributes=oa;
            
%             detections{k}=objectDetection('Measurement',dxdy,...
%                 'MeasurementNoise',diag([2,2]),'SensorIndex',1,...
%                 'ObjectClassID',0,'Time',time);
            VisualPositions(j,:)=dxdy;
        end
    end
    [ConfirmedTracks,TentativeTracks]=Tracker(detections,time);
    % PLOTS
    PositionSelector = [1 0 0 0; 0 0 1 0]; %for state vector [dx;vx;dy;vy] produces positions
    VelocitySelector = [0 1 0 0; 0 0 0 1]; %for state vector [dx;vx;dy;vy] produces velocities
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
    %Data
    data(i).detections=detections;
    data(i).tracks=ConfirmedTracks;
end