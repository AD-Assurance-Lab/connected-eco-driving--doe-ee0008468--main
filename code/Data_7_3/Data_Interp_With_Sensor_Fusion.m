%% Data Interp
%% Traffic Signal Notes
% note that the route driven was:
% 1. Mulberry/shields
% 2. Shields/Elizabeth
% 3. Shields/Prospect
% 4. Prospect/College
% 5. Prospect/Lemay
% 6. Lemay/Drake
% 7. Drake/College
% 8. College/Prospect
% 9. College/Mulberry
% Traffic signals will be interpolated in the following manner:
% Each signal will be assigned an index as above. The color of that 
% signal (Green/Yellow/Red -> 1,2,3) will be in the direction encountered 
% along the route. 
% For the intersections where right hand turns were made (5,6,7) the
% signals will be the through phase as there is no right hand turn phase.
% Left hand turns such as occurred at (1,3,9) will be treated as the left
% hand turn phase.
% The traffic signal phases in Ft. Collins are:
% Phase 1 	NB LT
% Phase 2	SB Thru
% Phase 3 	WB LT
% Phase 4	EB Thru
% Phase 5	SB LT
% Phase 6	NB Thru
% Phase 7	EB LT
% Phase 8	WB Thru
%
% So that means that the phases which are considered "forward along the
% route" are:
% Signal                 Forward Phase
% 1. Mulberry/shields    Phase 3 	WB LT
% 2. Shields/Elizabeth   Phase 2	SB Thru
% 3. Shields/Prospect    Phase 5	SB LT
% 4. Prospect/College    Phase 4	EB Thru
% 5. Prospect/Lemay      Phase 4	EB Thru
% 6. Lemay/Drake         Phase 2	SB Thru
% 7. Drake/College       Phase 8	WB Thru
% 8. College/Prospect    Phase 6	NB Thru
% 9. College/Mulberry    Phase 1 	NB LT
%
% When a signal is not at its designated "Forward" phase it will be
% considered to be "red" (3).
%% Time Synchronization Notes
% The data time indices are all in seconds from midnight (00:00:00) on
% 5/15/2019. The test satrted very close to 3:35 PM (15:35:00) on this day 
% which is 56100 seconds from midnight. Becasue the V2V, V2I, and TSP data
% were all recorded with a time index from (00:00:00) they can be assumed
% to all be synchronized. However, the ADAS data was recorded based on
% seconds from the start of the test and thus has to be start-time adjsuted
% to fit. Note that in Data_Concat.m this data was adjusted such that the
% start of the ADAS data is at 51600 s.
%%
clc; clear all;
addpath(genpath(pwd));
%% Input parameters
% Data file
rawDataFile='RawData3.mat';
% synchronization start-time adjustments for the data sets
Sync_ADAS=0; %s
Sync_V2V=-5*3600; %s
Sync_V2I=0; %s
Sync_TSP=0; %s
Sync_Ego=-5*3600; %s
% Interpolation parameters
Sample_Period=.1; %s time period on interpolated sample.
KeepRawADAS=0;
%% Method
load(rawDataFile);
data=RawData;
dataTemp=struct('name','','data',[]);
%dataTemp will be the structure used for interpolation
%% TSP
% In this section the TSP data is generated for "forward" directiona nd
% prepared for interpolation.
Encoding=[1:1:9;3,2,5,4,4,2,8,6,1]; %signal index -> "forward" phase index
% Initializing trafficSignals structure
trafficSignals=struct('time',[],'signal',[]);
for i=1:1:numel(data.TSP)
    trafficSignals(i).time=zeros(1,numel(data.TSP(i).data.frame));
    trafficSignals(i).signal=3*ones(1,numel(data.TSP(i).data.frame));
end
for j=1:1:numel(trafficSignals) %index of signals
    for i=1:1:numel(data.TSP(j).data.frame)
        %index of frames (different for each traffic light)
        phase=Encoding(2,j);
        phaseString=sprintf('phase #%i',phase);
        trafficSignals(j).time(i)=data.TSP(j).data.frame(i).time;
        for k=1:1:numel(data.TSP(j).data.frame(i).signal)
            %since the phases are initialized as "red" (3) they are only
            %changed if the assigned "forward" phase is "yellow" (2) or 
            %"green" (1)
            if strcmpi(phaseString,data.TSP(j).data.frame(i).signal(k).detail)
                if strcmpi('Phase Green',data.TSP(j).data.frame(i).signal(k).phase)
                    trafficSignals(j).signal(i)=1;
                elseif strcmpi('Phase Yellow',data.TSP(j).data.frame(i).signal(k).phase)
                    trafficSignals(j).signal(i)=2;
                end
            end
        end
    end
end
% Adding TSP data to interpolation structure
for i=1:1:numel(trafficSignals)
    dataTemp(i).name=sprintf('TSP_%i_%s',i,strrep(data.TSP(i).name,'&','_'));
    dataTemp(i).data=[trafficSignals(i).time;trafficSignals(i).signal]';
end
%% V2I
j=numel(dataTemp);
for i=1:1:numel(data.V2I)
    j=j+1;
    dataTemp(j).name=sprintf('V2I_%i_%s_SegmentSpeed',i,data.V2I(i).name);
    dataTemp(j).data=[data.V2I(i).data.time';data.V2I(i).data.segmentSpeed]';
    j=j+1;
    dataTemp(j).name=sprintf('V2I_%i_%s_SegmentTime',i,data.V2I(i).name);
    dataTemp(j).data=[data.V2I(i).data.time';data.V2I(i).data.segmentTime]';
end
%% V2V
j=numel(dataTemp);
for i=1:1:numel(data.V2V)
    f=fields(data.V2V(i).data);
    for k=1:1:numel(f)
        j=j+1;
        c=f(i); s=c{:};
        dataTemp(j).name=sprintf('V2V_%i_%s',k,s);
        dataTemp(j).data=data.V2V(i).(s);
    end
end
%% EGO
j=numel(dataTemp);
%% ADAS
j=numel(dataTemp);
ADAS_Start=j+1;
f=fields(data.ADAS);
for i=1:1:numel(f)
    j=j+1;
    c=f(i); s=c{:};
    dataTemp(j).name=sprintf('ADAS_%i_%s',i,s);
    dataTemp(j).data=data.ADAS.(s);
end
%% Interpolation
startTime=zeros(1,numel(dataTemp));
endTime=zeros(1,numel(dataTemp));
for i=1:1:numel(dataTemp)
    dataTemp(i).data(:,1)=dataTemp(i).data(:,1)-dataTemp(i).data(1,1);
    startTime(i)=dataTemp(i).data(1,1);
    endTime(i)=dataTemp(i).data(end,1);
end
[~,i]=max(startTime);
firstFrame=dataTemp(i).data(1,1);
[~,i]=min(endTime);
lastFrame=dataTemp(i).data(end,1);
sampleTime=[firstFrame:Sample_Period:lastFrame];
condition=DataInterpCondition('TSP',[1:1:3],'nearest');
InterpolatedData.data=QueryTestData(dataTemp,sampleTime,'linear',condition);
InterpolatedData.time=sampleTime-sampleTime(1);
%% Sensor Fusion
%Performing sensor fusion on ADAS data (This can take a while)
% DataOut=SensorFusion_InterpolatedData(InterpolatedData);
load('DataOut.mat');
%% Organizing the Fused Data
load('InterpolatedData_10Hz_Cut.mat')
[InterpolatedData]=AddTracksToIntData(InterpolatedData,DataOut,ADAS_Start,KeepRawADAS);