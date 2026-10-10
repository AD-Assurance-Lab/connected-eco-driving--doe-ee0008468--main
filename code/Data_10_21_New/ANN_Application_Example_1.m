%% ANN Training Script (Proof of Concept)
% Very basic experiment on training shallow ANNs with various datasets
%% Loading in Data
load('DataStreamsByDistance.mat');
%% Data Stucture
Results=struct('EGO',[],'EGO_SPaT',[],'EGO_LV',[],'EGO_SS',[],'EGO_V2V',[],...
    'EGO_SPaT_LV',[],'EGO_SPaT_SS',[],'EGO_SPaT_V2V',[],...
    'EGO_LV_SS',[],'EGO_LV_V2V',[],'EGO_SS_V2V',[],...
    'EGO_SPaT_LV_SS',[],'EGO_SPaT_LV_V2V',[],...
    'EGO_SPaT_SS_V2V',[],'EGO_SPaT_LV_SS_V2V',[]);
%% Ego Data - Distance
Results.EGO=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO.x = [DataStreamsByDistance.EgoDistance]';
Results.EGO.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO]=TrainFunction(Results.EGO);
%% EGO_LV Data - Distance
Results.EGO_SPaT=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance]';
Results.EGO_SPaT.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT]=TrainFunction(Results.EGO_SPaT);
%% EGO_LV Data - Distance
Results.EGO_LV=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_LV.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.LVDistance]';
Results.EGO_LV.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_LV]=TrainFunction(Results.EGO_LV);
%% EGO_SS Data - Distance
Results.EGO_SS=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SS.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SSDistance]';
Results.EGO_SS.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SS]=TrainFunction(Results.EGO_SS);
%% EGO_V2V Data - Distance
Results.EGO_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.V2VDistance]';
Results.EGO_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_V2V]=TrainFunction(Results.EGO_V2V);
%% EGO_SPaT_LV Data - Distance
Results.EGO_SPaT_LV=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_LV.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance DataStreamsByDistance.LVDistance]';
Results.EGO_SPaT_LV.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_LV]=TrainFunction(Results.EGO_SPaT_LV);
%% EGO_SPaT_SS Data - Distance
Results.EGO_SPaT_SS=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_SS.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance DataStreamsByDistance.SSDistance]';
Results.EGO_SPaT_SS.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_SS]=TrainFunction(Results.EGO_SPaT_SS);
%% EGO_SPaT_V2V Data - Distance
Results.EGO_SPaT_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance DataStreamsByDistance.V2VDistance]';
Results.EGO_SPaT_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_V2V]=TrainFunction(Results.EGO_SPaT_V2V);
%% EGO_LV_SS Data - Distance
Results.EGO_SPaT_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance DataStreamsByDistance.V2VDistance]';
Results.EGO_SPaT_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_V2V]=TrainFunction(Results.EGO_SPaT_V2V);
%% EGO_LV_V2V Data - Distance
Results.EGO_SPaT_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance DataStreamsByDistance.V2VDistance]';
Results.EGO_SPaT_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_V2V]=TrainFunction(Results.EGO_SPaT_V2V);
%% EGO_SS_V2V Data - Distance
Results.EGO_SPaT_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance DataStreamsByDistance.V2VDistance]';
Results.EGO_SPaT_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_V2V]=TrainFunction(Results.EGO_SPaT_V2V);