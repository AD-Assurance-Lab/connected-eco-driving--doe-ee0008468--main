clc; clear all; close all; addpath(genpath(pwd));
%% Imputs
sync=1; %sync data time scales
testStartTime=13*3600+43*60+40; %seconds from midnight
%% Traffic Signal Phases
tsp_output=ConcatenateTSPDataCombined('TSP_7_3_2019.xlsx',11);
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
v2v_output=struct('name','','data',[]);
v2v_output(1).name='V2V_1_D06';
v2v_output(1).data=PullFromSingleFreematicsFile('D06.csv');
v2v_output(2).name='V2V_2_D02';
v2v_output(2).data=PullFromSingleFreematicsFile('D02.csv');
v2v_output(3).name='V2V_3_D03';
v2v_output(3).data=PullFromSingleFreematicsFile('D03.csv');
%% EGO
ego_output.data=PullFromManyFreematicsFiles('Ego');
%% ADAS
ADAS_output=load('Data_7_3.mat');
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