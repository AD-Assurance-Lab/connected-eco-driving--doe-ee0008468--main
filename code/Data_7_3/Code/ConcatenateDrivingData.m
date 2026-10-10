function dataOut=ConcatenateDrivingData(dataIn,GXIndex,GYIndex,LongitudinalIndex,LateralIndex,GPSSPeedIndex,GPSPrecisionIndex,GPSAltitudeIndex,GPSBearingIndex,adjFlag)
dataOut=struct('time',[],'GX',[],'GY',[],'Longitude',...
    [],'Latitude',[],'GPSSpeed',[],'Precision',[],'Altitude',[],'Bearing',[]);
%% Data Import
% dataOut.time=time;
%% Time Vector Generation
% timeCells=dataIn.text(2:end,1)';
% time=zeros(1,numel(timeCells));
% for i=1:1:numel(timeCells)
%     c=timeCells(i);
%     s=c{:};
%     if ~strcmpi(s,'GPS Time')
%     timeString=s(12:19);
%     H=str2double(s(12:13));
%     M=str2double(s(15:16));
%     S=str2double(s(18:19));
%     time(i)=H*3600+M*60+S;
%     end
% end
timeTemp=dataIn.data(:,1);
timeTemp=timeTemp*3600*24;
time=zeros(1,numel(timeTemp));
add=15*3600;
minima=find(islocalmin(timeTemp));
for i=1:1:numel(timeTemp)
    for j=1:1:numel(minima)
        if i==minima(j)
            disp('a')
            add=add+1*3600;
        end
    end
time(i)=timeTemp(i)+add;
end
% GX=dataIn.data(:,GXIndex)';
% GY=dataIn.data(:,GYIndex)';
% Longitude=dataIn.data(:,LongitudinalIndex)';
% Latitude=dataIn.data(:,LateralIndex)';
% GPSSpeed=dataIn.data(:,GPSSPeedIndex)';
% Precision=dataIn.data(:,GPSPrecisionIndex)';
% Altitude=dataIn.data(:,GPSAltitudeIndex)';
% Bearing=dataIn.data(:,GPSBearingIndex)';
% 
% [c,ia]=unique(time);
% dataOut.time=c;
% dataOut.GX=GX(ia);
% dataOut.GY=GY(ia);
% dataOut.Longitude=Longitude(ia);
% dataOut.Latitude=Latitude(ia);
% dataOut.GPSSpeed=GPSSpeed(ia);
% dataOut.Precision=Precision(ia);
% dataOut.Altitude=Altitude(ia);
% dataOut.Bearing=Bearing(ia);

dataOut.time=time;
dataOut.GX=dataIn.data(:,GXIndex)';
dataOut.GY=dataIn.data(:,GYIndex)';
dataOut.Longitude=dataIn.data(:,LongitudinalIndex)';
dataOut.Latitude=dataIn.data(:,LateralIndex)';
dataOut.GPSSpeed=dataIn.data(:,GPSSPeedIndex)';
dataOut.Precision=dataIn.data(:,GPSPrecisionIndex)';
dataOut.Altitude=dataIn.data(:,GPSAltitudeIndex)';
dataOut.Bearing=dataIn.data(:,GPSBearingIndex)';
end