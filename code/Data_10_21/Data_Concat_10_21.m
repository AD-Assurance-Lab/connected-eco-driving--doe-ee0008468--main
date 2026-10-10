clc; clear all; close all; addpath(genpath(pwd));
%% Imputs 10/21
SSFolder='SS';
date='10_21';
SPaTFile='Signal Change Data 10_21_2019 1300 to 1900.xlsx';
CANData=load('Drive_10_21_2.mat');
RawData_10_21=Data_Import_Function(date,SSFolder,SPaTFile,CANData);
%% Imputs 10/22
Sample_Period=.5;
SSFolder='SS';
date='10_22';
SPaTFile='Signal Change Data 10_22_2019 1300 to 1900.xlsx';
CANData=load('Drive_10_22_1.mat');
RawData_10_22=Data_Import_Function(date,SSFolder,SPaTFile,CANData);
%% Interpolation 10/21
Sample_Period=.5;
[TimeInterpolatedData_10_21]=Data_Time_Interp_Function(RawData_10_21,Sample_Period);
%% Interpolation 10/22
Sample_Period=.5;
[TimeInterpolatedData_10_22]=Data_Time_Interp_Function(RawData_10_22,Sample_Period);