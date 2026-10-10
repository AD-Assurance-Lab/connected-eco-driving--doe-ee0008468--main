%% EGO_LV_SS Data - Distance
Results.EGO_SPaT_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.LVDistance DataStreamsByDistance.SSDistance]';
Results.EGO_SPaT_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_V2V]=TrainFunction(Results.EGO_SPaT_V2V);
%% EGO_LV_V2V Data - Distance
Results.EGO_LV_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_LV_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.LVDistance DataStreamsByDistance.V2VDistance]';
Results.EGO_LV_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_LV_V2V]=TrainFunction(Results.EGO_LV_V2V);
%% EGO_SS_V2V Data - Distance
Results.EGO_SS_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SS_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SSDistance DataStreamsByDistance.V2VDistance]';
Results.EGO_SS_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SS_V2V]=TrainFunction(Results.EGO_SS_V2V);
%% EGO_SPaT_LV_SS Data - Distance
Results.EGO_SPaT_LV_SS=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_LV_SS.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance DataStreamsByDistance.LVDistance DataStreamsByDistance.SSDistance]';
Results.EGO_SPaT_LV_SS.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_LV_SS]=TrainFunction(Results.EGO_SPaT_LV_SS);
%% EGO_SPaT_LV_V2V Data - Distance
Results.EGO_SPaT_LV_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_LV_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance DataStreamsByDistance.LVDistance DataStreamsByDistance.V2VDistance]';
Results.EGO_SPaT_LV_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_LV_V2V]=TrainFunction(Results.EGO_SPaT_LV_V2V);
%% EGO_SPaT_SS_V2V Data - Distance
Results.EGO_SPaT_SS_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_SS_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance DataStreamsByDistance.SSDistance DataStreamsByDistance.V2VDistance]';
Results.EGO_SPaT_SS_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_SS_V2V]=TrainFunction(Results.EGO_SPaT_SS_V2V);
%% EGO_SPaT_LV_SS_V2V Data - Distance
Results.EGO_SEGO_SPaT_LV_SS_V2VPaT_V2V=struct('network',[],'x',[],'t',[],'y',[],'mse',[]);

Results.EGO_SPaT_LV_SS_V2V.x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance DataStreamsByDistance.LVDistance DataStreamsByDistance.SSDistance DataStreamsByDistance.V2VDistance]';
Results.EGO_SPaT_LV_SS_V2V.t = [DataStreamsByDistance.TargetSpeeds]';

[Results.EGO_SPaT_LV_SS_V2V]=TrainFunction(Results.EGO_SPaT_LV_SS_V2V);