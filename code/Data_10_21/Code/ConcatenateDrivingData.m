function dataOut=ConcatenateDrivingData(dataIn,GXIndex,GYIndex,LongitudinalIndex,LateralIndex,GPSSPeedIndex,GPSPrecisionIndex,GPSAltitudeIndex,GPSBearingIndex,adjFlag)
dataOut=struct('time',[],'GX',[],'GY',[],'Longitude',...
    [],'Latitude',[],'GPSSpeed',[],'Precision',[],'Altitude',[],'Bearing',[]);
%% Time Vector Generation
timeCells=dataIn.text(2:end,1)';
time=zeros(1,numel(timeCells));
for i=1:1:numel(timeCells)
    c=timeCells(i);
    s=c{:};
    if ~strcmpi(s,'GPS Time')
    timeString=s(12:19);
    H=str2double(s(12:13));
    M=str2double(s(15:16));
    S=str2double(s(18:19));
    time(i)=H*3600+M*60+S;
    end
end
dataOut.time=time';
dataOut.GX=dataIn.data(:,GXIndex);
dataOut.GY=dataIn.data(:,GYIndex);
dataOut.Longitude=dataIn.data(:,LongitudinalIndex);
dataOut.Latitude=dataIn.data(:,LateralIndex);
dataOut.GPSSpeed=dataIn.data(:,GPSSPeedIndex);
dataOut.Precision=dataIn.data(:,GPSPrecisionIndex);
dataOut.Altitude=dataIn.data(:,GPSAltitudeIndex);
dataOut.Bearing=dataIn.data(:,GPSBearingIndex);
end