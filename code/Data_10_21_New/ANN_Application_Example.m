%% ANN Training Script (Proof of Concept)
% Very basic experiment on training shallow ANNs with various datasets
%% Ego Data - Distance
x = [DataStreamsByDistance.EgoDistance]';
t = [DataStreamsByDistance.TargetSpeeds]';

trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = 10;
netEgoDist = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
netEgoDist.divideParam.trainRatio = 70/100;
netEgoDist.divideParam.valRatio = 15/100;
netEgoDist.divideParam.testRatio = 15/100;

% Train the Network
[netEgoDist,tr] = train(netEgoDist,x,t);

%% Test the Network
x = [DataStreamsByDistance.EgoDistance]';
t = [DataStreamsByDistance.TargetSpeeds]';
y = netEgoDist(x);
figure; hold on; plot(y-t);
%
errorEgoDist = gsubtract(t,y);
performanceEgoDist = perform(net1,t,y);
mseEgoDist=immse(t,y);
%% Save the Data
EgoDistResults=struct('network',netEgoDist,'x',x,'t',t,'y',y,'mse',mseEgoDist);
save('EgoDistResults.mat','EgoDistResults');
%% Ego + SPaT Data - Distance
x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance]';
t = [DataStreamsByDistance.TargetSpeeds]';

trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = 10;
netEgoSPaTDist = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
netEgoSPaTDist.divideParam.trainRatio = 70/100;
netEgoSPaTDist.divideParam.valRatio = 15/100;
netEgoSPaTDist.divideParam.testRatio = 15/100;

% Train the Network
[netEgoSPaTDist,tr] = train(netEgoSPaTDist,x,t);

%% Test the Network
x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.SPaTDistance]';
t = [DataStreamsByDistance.TargetSpeeds]';
y = netEgoSPaTDist(x);
figure; hold on; plot(y-t);
%
errorEgoSPaTDist = gsubtract(t,y);
performanceEgoSPaTDist = perform(net1,t,y);
mseEgoSPaTDist=immse(t,y);
%% Save the Data
EgoDistSPaTResults=struct('network',netEgoSPaTDist,'x',x,'t',t,'y',y,'mse',mseEgoSPaTDist);
save('EgoDistSPaTResults.mat','EgoDistSPaTResults');
%% Ego + V2V Data - Distance
x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.V2VDistance]';
t = [DataStreamsByDistance.TargetSpeeds]';

trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = 10;
netEgoV2VDist = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
netEgoV2VDist.divideParam.trainRatio = 70/100;
netEgoV2VDist.divideParam.valRatio = 15/100;
netEgoV2VDist.divideParam.testRatio = 15/100;

% Train the Network
[netEgoV2VDist,tr] = train(netEgoV2VDist,x,t);

%% Test the Network
x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.V2VDistance]';
t = [DataStreamsByDistance.TargetSpeeds]';
y = netEgoV2VDist(x);
figure; hold on; plot(y-t);
%
errorEgoV2VDist = gsubtract(t,y);
performanceEgoV2VDist = perform(net1,t,y);
mseEgoV2VDist=immse(t,y);
%% Save the Data
EgoDistV2VResults=struct('network',netEgoV2VDist,'x',x,'t',t,'y',y,'mse',mseEgoV2VDist);
save('EgoDistV2VResults.mat','EgoDistV2VResults');
%% Ego + LV Data - Distance
x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.LVDistance]';
t = [DataStreamsByDistance.TargetSpeeds]';

trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = 10;
netEgoLVDist = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
netEgoLVDist.divideParam.trainRatio = 70/100;
netEgoLVDist.divideParam.valRatio = 15/100;
netEgoLVDist.divideParam.testRatio = 15/100;

% Train the Network
[netEgoLVDist,tr] = train(netEgoLVDist,x,t);

%% Test the Network
x = [DataStreamsByDistance.EgoDistance DataStreamsByDistance.V2VDistance]';
t = [DataStreamsByDistance.TargetSpeeds]';
y = netEgoLVDist(x);
figure; hold on; plot(y-t);
%
errorEgoV2VDist = gsubtract(t,y);
performanceEgoV2VDist = perform(net1,t,y);
mseEgoV2VDist=immse(t,y);
%% Save the Data
EgoDistV2VResults=struct('network',netEgoV2VDist,'x',x,'t',t,'y',y,'mse',mseEgoV2VDist);
save('EgoDistV2VResults.mat','EgoDistV2VResults');