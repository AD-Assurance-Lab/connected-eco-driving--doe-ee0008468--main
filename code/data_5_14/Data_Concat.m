clc; clear all; close all; addpath(genpath(pwd));
%% Imputs
sync=1; %sync data time scales
testStartTime=15*60*60+35*60; %seconds from midnight
%% Traffic Signal Phases
tsp_import=struct('data',[],'text',[]);
[~,sheets]=xlsfinfo('TrafficSignals.xlsx');
for i=1:1:numel(sheets)
    [tsp_import(i).data,tsp_import(i).text]=xlsread('TrafficSignals.xlsx',i);
end
tsp_output=struct('name','','data',[]);
for i=2:1:numel(sheets)
    c=sheets(i);
    s=c{:};
    tsp_output(i-1).name=s;
    tsp_output(i-1).data=ConcatenateTSPData(tsp_import(i));
end
%% V2I
fileList=dir('V2I');
v2i_import=struct('data',[],'text',[]);
v2i_output=struct('name','','data',[]);
j=0;
for i=1:1:numel(fileList)
    [~,~,ext]=fileparts(fileList(i).name);
    if strcmpi(ext,'.csv')==1
        j=j+1;
        [v2i_import.data,v2i_import.text]=xlsread(fileList(i).name);
        
        v2i_output(j).name=fileList(i).name;
        v2i_output(j).data=ConcatenateV2IData(v2i_import);
    end
end
%% V2V
v2v_import=struct('data',[],'text',[]);
[v2v_import(1).data,v2v_import(1).text]=xlsread('D01.csv'); %V2V data from D01 5/15/2019
[v2v_import(2).data,v2v_import(2).text]=xlsread('D02.csv'); %V2V data from D01 5/15/2019
[v2v_import(3).data,v2v_import(3).text]=xlsread('D041.csv'); %V2V data from D04 5/15/2019
v2v_output=struct('name','','data',[]);
v2v_output(1).name='V2V_1_D01';
v2v_output(1).data=ConcatenateDrivingData(v2v_import(1),8,9,2,3,4,5,6,7,1);
v2v_output(2).name='V2V_2_D02';
v2v_output(2).data=ConcatenateDrivingData(v2v_import(2),8,9,2,3,4,5,6,7,1);
v2v_output(3).name='V2V_3_D04';
v2v_output(3).data=ConcatenateDrivingData(v2v_import(3),8,9,2,3,4,5,6,7,1);
%% EGO
ego_output=v2v_output(1).data;
ego_output.EngineLoad=v2v_import(1).data(:,35)';
ego_output.EngineSpeed=v2v_import(1).data(:,38)';
ego_output.ThrottlePos=v2v_import(1).data(:,59)';
%% ADAS
ADAS_output=load('V2V_Urban_5_15.mat');
if sync==1
    f=fields(ADAS_output);
    for i=1:1:numel(f)
        c=f(i);
        s=c{:};
        ADAS_output.(s)(:,1)=ADAS_output.(s)(:,1)+testStartTime;
    end
end
%% Raw Data
RawData=struct('EGO',[],'ADAS',[],'V2V',[],'V2I',[],'TSP',[]);
RawData.EGO=ego_output;
RawData.ADAS=ADAS_output;
RawData.V2V=v2v_output;
RawData.V2I=v2i_output;
RawData.TSP=tsp_output;