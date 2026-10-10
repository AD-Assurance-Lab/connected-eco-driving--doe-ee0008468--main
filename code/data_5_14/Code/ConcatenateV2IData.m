function [dataOut]=ConcatenateV2IData(dataIn)
dataOut=struct('time',[],'MI',[],'segmentTime',[],'segmentSpeed',[]);
dataOut.time=dataIn.data(:,1)*24*60*60';
dataOut.MI=[1:1:numel(dataIn.data(:,1))];
dataOut.segmentTime=dataIn.data(:,2)';
dataOut.segmentSpeed=dataIn.data(:,3)';
end