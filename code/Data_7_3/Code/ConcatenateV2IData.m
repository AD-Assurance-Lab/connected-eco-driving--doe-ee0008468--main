function [dataOut]=ConcatenateV2IData(dataIn)
dataOut=struct('time',[],'segmentTime',[],'segmentSpeed',[]);
% dataOut.time=dataIn.data(:,1)*24*60*60';
% dataOut.MI=[1:1:numel(dataIn.data(:,1))];
% dataOut.segmentTime=dataIn.data(:,2)';
% dataOut.segmentSpeed=dataIn.data(:,3)';
time=dataIn.data(:,1)*24*60*60';
segmentTime=dataIn.data(:,2)';
segmentSpeed=dataIn.data(:,3)';
measurements=struct('indices',[]);
[c,ia]=unique(time);
for i=1:1:numel(ia)-1
    measurements(i).indices=[ia(i):1:ia(i+1)-1];
end
measurements(i+1).indices=[ia(end):1:numel(time)];
dataOut.time=c;
for i=1:1:numel(measurements)
    dataOut.segmentTime(i)=mean(segmentTime(measurements(i).indices));
    dataOut.segmentSpeed(i)=mean(segmentSpeed(measurements(i).indices));
end