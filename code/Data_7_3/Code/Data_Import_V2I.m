clc; clear all; close all;
%% Data Import
import=struct('data',[],'text',[]);
[import(1).data,import(1).text]=xlsread('CollegeDrakeToProspect.csv');
[import(2).data,import(2).text]=xlsread('CollegeProspectToMulberry.csv');
[import(3).data,import(3).text]=xlsread('DrakeLemayToCollege.csv');
[import(4).data,import(4).text]=xlsread('CollegeDrakeToProspect.csv');
[import(5).data,import(5).text]=xlsread('CollegeDrakeToProspect.csv');
[import(6).data,import(6).text]=xlsread('CollegeDrakeToProspect.csv');
[import(7).data,import(7).text]=xlsread('CollegeDrakeToProspect.csv');
[import(8).data,import(8).text]=xlsread('CollegeDrakeToProspect.csv');
output=struct('name','','data',[]);
output(1).name='CollegeDrakeToProspect';
output(1).data=ConcatenateV2IData(import(1));