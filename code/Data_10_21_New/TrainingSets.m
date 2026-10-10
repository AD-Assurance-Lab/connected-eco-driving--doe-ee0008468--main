%% Generating DataSets for ANN Training
%% Just Ego Data By Distance
EgoDistance=[];
for i=1:1:13
    EgoDistance=[EgoDistance; ...
        DataStruct(i).AccelPedalPos' DataStruct(i).BrakePedalPos' ...
        DataStruct(i).TransmissionGear' DataStruct(i).EngineSpeed' DataStruct(i).EngineTorque' ...
        DataStruct(i).TurnSignal'  DataStruct(i).AccLong' ...
        DataStruct(i).AccLat' DataStruct(i).YawRate' DataStruct(i).Altitude' ...
        DataStruct(i).SteerAngle' DataStruct(i).Time' DataStruct(i).VehicleSpeed'];
end
TargetSpeeds=EgoDistance(21:end,end);
EgoDistance=EgoDistance(1:end-20,:);
%% Just V2V
V2VDistance=[];
for i=1:1:13
    V2VDistance=[V2VDistance;...
        Field2Vec(DataStruct(i).V2V,'meanSpeed')' Field2Vec(DataStruct(i).V2V,'sigmaSpeed')'];
end
V2VDistance=V2VDistance(1:end-20,:);
%% Just SS
SSDistance=[];
for i=1:1:13
    SSDistance=[SSDistance;...
        Field2Vec(DataStruct(i).SS,'speed')' Field2Vec(DataStruct(i).SS,'distanceRemaining')'];
end
SSDistance=SSDistance(1:end-20,:);
%% Just SPaT
SPaTDistance=[];
for i=1:1:13
    SPaTDistance=[SPaTDistance;...
        Field2Mat(DataStruct(i).SPaT,'distances') Field2Mat(DataStruct(i).SPaT,'phases')];
end
SPaTDistance=SPaTDistance(1:end-20,:);
%% Just LV
LVDistance=[];
for i=1:1:13
    LVDistance=[LVDistance;...
        Field2Vec(DataStruct(i).LV,'dx')' Field2Vec(DataStruct(i).LV,'dy')' ...
        [0 diff(Field2Vec(DataStruct(i).LV,'dx'))./diff(DataStruct(i).Time)]'];
end
LVDistance=LVDistance(1:end-20,:);
%%
DataStreamsByDistance=struct('TargetSpeeds',TargetSpeeds,'EgoDistance',EgoDistance,'V2VDistance',V2VDistance,...
    'SSDistance',SSDistance,'SPaTDistance',SPaTDistance,'LVDistance',LVDistance);