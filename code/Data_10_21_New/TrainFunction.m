function [InStruct]=TrainFunction(InStruct)
trainFcn = 'trainlm';  % Levenberg-Marquardt backpropagation.

% Create a Fitting Network
hiddenLayerSize = 10;
InStruct.network = fitnet(hiddenLayerSize,trainFcn);

% Setup Division of Data for Training, Validation, Testing
InStruct.network.divideParam.trainRatio = 70/100;
InStruct.network.divideParam.valRatio = 15/100;
InStruct.network.divideParam.testRatio = 15/100;

% Train the Network
[InStruct.network] = train(InStruct.network,InStruct.x,InStruct.t);

% Test the Network
InStruct.y = InStruct.network(InStruct.x);

InStruct.mse=immse(InStruct.t,InStruct.y);
end