%% V2I and TSP Locations and Information
% This script puts together the locations and some data for traffic signals
% and V2I segmants in Ft. Collins
%%
clc; clear all; close all;
%% TSP
[data,txt]=xlsread('TrafficSignalLocations.xlsx');
%%
figure
scatter(data(:,4),data(:,5),10)
axis equal