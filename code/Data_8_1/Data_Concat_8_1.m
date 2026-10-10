clc; clear all; close all; addpath(genpath(pwd));
%% Imputs
sync=1; %sync data time scales
testStartTime=14*3600+37*60+12.281; %seconds from midnight
%% Traffic Signal Phases
tsp_output=ConcatenateTSPDataCombined('Signals1.xlsx',8);
%% V2I
fileList=dir('V2I');
v2i_import=struct('data',[],'text',[]);
v2i_output=struct('name','','data',[]);
j=0;
for i=1:1:numel(fileList)
    [~,nameString,ext]=fileparts(fileList(i).name);
    if strcmpi(ext,'.csv')==1
        j=j+1;
        [v2i_import.data,v2i_import.text]=xlsread(fileList(i).name);
        
        v2i_output(j).name=nameString;
        v2i_output(j).data=ConcatenateV2IData(v2i_import);
    end
end
%% V2V
v2v_output=struct('name','','data',[]);
v2v_output(1).name='V2V_2_D02';
v2v_output(1).data=PullFromSingleFreematicsFile('D02.csv');
v2v_output(2).name='V2V_3_D03';
v2v_output(2).data=PullFromSingleFreematicsFile('D03.csv');
v2v_output(1)=FilterV2V(v2v_output(1));
v2v_output(2)=FilterV2V(v2v_output(2));
%% EGO
[ego_import.data,ego_import.text]=xlsread('EgoData.csv');
ego_output=ConcatenateDrivingData(ego_import,8,9,2,3,4,5,6,7,1);
ego_output.EngineLoad=ego_import.data(:,35);
ego_output.EngineSpeed=ego_import.data(:,38);
ego_output.ThrottlePos=ego_import.data(:,59);
f=fields(ego_output);
for i=1:1:numel(f)
    c=f(i); s=c{:};
    if ~strcmpi(s,'time')
        ego_output.(s)=[ego_output.time ego_output.(s)];
    end
end
ego_output=rmfield(ego_output,'time');
%% ADAS
ADAS_output=load('Data_8_1_2.mat');
ADAS_output.Time=ADAS_output.Time+testStartTime;
f=fields(ADAS_output);
for i=1:1:numel(f)
    c=f(i); s=c{:};
    if ~strcmpi(s,'Time')
        ADAS_output.(s)=[ADAS_output.Time ADAS_output.(s)];
    end
end
ADAS_output=rmfield(ADAS_output,'Time');
%% Raw Data
RawData=struct('EGO',[],'ADAS',[],'V2V',[],'V2I',[],'TSP',[]);
RawData.EGO=ego_output;
RawData.ADAS=ADAS_output;
RawData.V2V=v2v_output;
RawData.V2I=v2i_output;
RawData.TSP=tsp_output;