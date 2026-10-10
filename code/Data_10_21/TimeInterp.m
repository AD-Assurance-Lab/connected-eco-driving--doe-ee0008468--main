%% Constant Time Step Interpolation
%% Loading in data
load('DataByDistanceStruct.mat');
DataStructByTime=DataStruct;
%% Looping on Laps
n=.5; %time step
for i=1:1:numel(DataStruct)
    newTimeVector=[DataStruct(i).Time(1):n:DataStruct(i).Time(end)];
    DataStructByTime(i).Time=newTimeVector;
    DataStructByTime(i).Latitude=interp1(DataStruct(i).Time,DataStruct(i).Latitude,newTimeVector);
    DataStructByTime(i).Longitude=interp1(DataStruct(i).Time,DataStruct(i).Longitude,newTimeVector);
    DataStructByTime(i).Distance=interp1(DataStruct(i).Time,DataStruct(i).Distance,newTimeVector);
    DataStructByTime(i).AccelPedalPos=interp1(DataStruct(i).Time,DataStruct(i).AccelPedalPos,newTimeVector);
    DataStructByTime(i).BrakePedalPos=interp1(DataStruct(i).Time,DataStruct(i).BrakePedalPos,newTimeVector);
    DataStructByTime(i).TransmissionGear=interp1(DataStruct(i).Time,DataStruct(i).TransmissionGear,newTimeVector);
    DataStructByTime(i).EngineSpeed=interp1(DataStruct(i).Time,DataStruct(i).EngineSpeed,newTimeVector);
    DataStructByTime(i).MaxTorque=interp1(DataStruct(i).Time,DataStruct(i).MaxTorque,newTimeVector);
    DataStructByTime(i).MinTorque=interp1(DataStruct(i).Time,DataStruct(i).MinTorque,newTimeVector);
    DataStructByTime(i).EngineTorque=interp1(DataStruct(i).Time,DataStruct(i).EngineTorque,newTimeVector);
    DataStructByTime(i).TurnSignal=interp1(DataStruct(i).Time,DataStruct(i).TurnSignal,newTimeVector);
    DataStructByTime(i).VehicleSpeed=interp1(DataStruct(i).Time,DataStruct(i).VehicleSpeed,newTimeVector);
    DataStructByTime(i).AccLong=interp1(DataStruct(i).Time,DataStruct(i).AccLong,newTimeVector);
    DataStructByTime(i).AccLat=interp1(DataStruct(i).Time,DataStruct(i).AccLat,newTimeVector);
    DataStructByTime(i).YawRate=interp1(DataStruct(i).Time,DataStruct(i).YawRate,newTimeVector);
    DataStructByTime(i).Altitude=interp1(DataStruct(i).Time,DataStruct(i).Altitude,newTimeVector);
    DataStructByTime(i).SteerAngle=interp1(DataStruct(i).Time,DataStruct(i).SteerAngle,newTimeVector);
    DataStructByTime(i).SPaT=struct('indices',[],'distances',[],'phases',[]);
    indices=interp1(DataStruct(i).Time,Field2Mat(DataStruct(i).SPaT,'indices'),newTimeVector,'nearest');
    distances=interp1(DataStruct(i).Time,Field2Mat(DataStruct(i).SPaT,'distances'),newTimeVector);
    phases=interp1(DataStruct(i).Time,Field2Mat(DataStruct(i).SPaT,'phases'),newTimeVector,'nearest');
    for j=1:1:numel(newTimeVector)
        DataStructByTime(i).SPaT(j).indices=indices(j,:);
        DataStructByTime(i).SPaT(j).distances=distances(j,:);
        DataStructByTime(i).SPaT(j).phases=phases(j,:);
    end
    DataStructByTime(i).SS=struct('index',[],'speed',[],'distanceRemaining',[]);
    index=interp1(DataStruct(i).Time,Field2Vec(DataStruct(i).SS,'index'),newTimeVector,'nearest');
    speed=interp1(DataStruct(i).Time,Field2Vec(DataStruct(i).SS,'speed'),newTimeVector);
    distanceRemaining=interp1(DataStruct(i).Time,Field2Vec(DataStruct(i).SS,'distanceRemaining'),newTimeVector);
    for j=1:1:numel(newTimeVector)
        DataStructByTime(i).SS(j).index=index(j);
        DataStructByTime(i).SS(j).speed=speed(j);
        DataStructByTime(i).SS(j).distanceRemaining=distanceRemaining(j);
    end
    DataStructByTime(i).V2V=struct('meanSpeed',[],'sigmaSpeed',[]);
    meanSpeed=interp1(DataStruct(i).Time,Field2Vec(DataStruct(i).V2V,'meanSpeed'),newTimeVector);
    sigmaSpeed=interp1(DataStruct(i).Time,Field2Vec(DataStruct(i).V2V,'sigmaSpeed'),newTimeVector);
    for j=1:1:numel(newTimeVector)
        DataStructByTime(i).V2V(j).meanSpeed=meanSpeed(j);
        DataStructByTime(i).V2V(j).sigmaSpeed=sigmaSpeed(j);
    end
    DataStructByTime(i).LV=struct('dx',[],'dy',[]);
    dx=interp1(DataStruct(i).Time,Field2Vec(DataStruct(i).LV,'dx'),newTimeVector);
    dy=interp1(DataStruct(i).Time,Field2Vec(DataStruct(i).LV,'dy'),newTimeVector);
    for j=1:1:numel(newTimeVector)
        DataStructByTime(i).LV(j).dx=dx(j);
        DataStructByTime(i).LV(j).dy=dy(j);
    end
end
%% Alligning time vectors
prevTime=0;
for i=1:1:numel(DataStruct)
    diffTime=DataStructByTime(i).Time(1)-prevTime;
    DataStructByTime(i).Time=DataStructByTime(i).Time-diffTime;
    prevTime=DataStructByTime(i).Time(end)+n;
end