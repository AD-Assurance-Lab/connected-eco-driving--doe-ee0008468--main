function dataOut=ConcatenateDrivingData(dataIn,GXIndex,GYIndex,LongitudinalIndex,LateralIndex,GPSSPeedIndex,GPSPrecisionIndex,GPSAltitudeIndex,GPSBearingIndex)
dataOut=struct('time',[],'GX',[],'GY',[],'Longitude',...
    [],'Latitude',[],'GPSSpeed',[],'Precision',[],'Altitude',[],'Bearing',[]);
%% Data Import
% dataOut.time=time;
dataOut.time=dataIn.data(:,1)'*24*60*60;
dataOut.GX=dataIn.data(:,GXIndex)';
dataOut.GY=dataIn.data(:,GYIndex)';
dataOut.Longitude=dataIn.data(:,LongitudinalIndex)';
dataOut.Latitude=dataIn.data(:,LateralIndex)';
dataOut.GPSSpeed=dataIn.data(:,GPSSPeedIndex)';
dataOut.Precision=dataIn.data(:,GPSPrecisionIndex)';
dataOut.Altitude=dataIn.data(:,GPSAltitudeIndex)';
dataOut.Bearing=dataIn.data(:,GPSBearingIndex)';
% dataOut.OBDSpeed=dataIn.data(:,OBDSPeedIndex)';
end