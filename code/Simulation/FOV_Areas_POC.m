%% FOV_Areas_POC
% Script for experimentation with defining and displaying Vehicle FOV areas
clc; clear all; close all;
%% Defining and displaying the areas rigidly
scenario=drivingScenario();
roadCenters=[0 0 0; 20 0 0];
laneSpecification = lanespec(3, 'Width', 4);
road(scenario, roadCenters, 'Lanes', laneSpecification);
egoCar=vehicle(scenario,'ClassID', 1,'Position',[10 0 0]);
% More information about FOV areas is available in "Defining Vehicle FOV
% Areas"
% Long Forward Cone
