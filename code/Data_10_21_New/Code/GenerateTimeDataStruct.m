function [EgoDataByDist]=GenerateTimeDataStruct(AllData,intersections,IntersectionGPS,ADASIndices,Segments,numLights,EGOIndices,n)
EgoDataByDist=struct('Time',[],'Latitude',[],'Longitude',[],'Distance',[],'AccelPedalPos',[],'BrakePedalPos',[],'TransmissionGear',[],'EngineSpeed',[],'MaxTorque',[],'MinTorque',[],'EngineTorque',[],'TurnSignal',[],'VehicleSpeed',[],'AccLong',[],'AccLat',[],'YawRate',[],'Altitude',[],'SteerAngle',[],'SPaT',[],'SS',[],'V2V',[],'LV',[]);
for i=1:1:numel(AllData)
    fprintf('Processing Lap %i\n',i)
    %% Making the structure
    EgoDataByDist(i).Time=[AllData(i).InterpolatedData.time(1):n:AllData(i).InterpolatedData.time(end)];
    EgoDataByDist(i).Latitude=interp1(AllData(i).LatLon.time,AllData(i).LatLon.lat,EgoDataByDist(i).Time);
    EgoDataByDist(i).Longitude=interp1(AllData(i).LatLon.time,AllData(i).LatLon.lon,EgoDataByDist(i).Time);
    EgoDataByDist(i).Distance=interp1(AllData(i).LatLon.time,AllData(i).LatLon.dist,EgoDataByDist(i).Time);
    EgoDataByDist(i).AccelPedalPos=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.AccelPedalPos).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).BrakePedalPos=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.BrakePedalPos).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).TransmissionGear=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.TransmissionGear).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).EngineSpeed=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.EngineSpeed).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).MaxTorque=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.MaxTorque).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).MinTorque=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.MinTorque).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).EngineTorque=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.EngineTorque).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).TurnSignal=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.TurnSignal).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).VehicleSpeed=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.VehicleSpeed).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).AccLong=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.AccLong).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).AccLat=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.AccLat).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).YawRate=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.YawRate).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).Altitude=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.Altitude).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).SteerAngle=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.SteerAngle).data,EgoDataByDist(i).Time);
    EgoDataByDist(i).SPaT=struct('indices',[],'distances',[],'phases',[]);
    EgoDataByDist(i).SS=struct('index',[],'speed',[],'distanceRemaining',[]);
    EgoDataByDist(i).V2V=struct('meanSpeed',[],'sigmaSpeed',[]);
    EgoDataByDist(i).LV=struct('dx',[],'dy',[]);
%     EgoDataByDist(i).LV=struct('dx',[],'dy',[],'TrnSig',[],'BrkLgt',[]);
    
    %Interpolated TSP
    clear InterpolatedTSP
    for j=1:1:numel(intersections(:,1)) %pulling for the intersections
        for k=1:1:numel(AllData(i).InterpolatedData.data)
            if regexp(AllData(i).InterpolatedData.data(k).name,string(intersections{j,1}))
                if regexp(AllData(i).InterpolatedData.data(k).name,string(intersections{j,2}))
                    tempPhases=AllData(i).InterpolatedData.data(k).data;
                    break
                end
            end
        end
%         assignin('base','out',interp1(AllData(i).LatLon.oldTime,tempPhases,EgoDataByDist(i).time));
        InterpolatedTSP(j,:)=interp1(AllData(i).LatLon.oldTime,tempPhases,EgoDataByDist(i).Time,'nearest'); %interpolating lat
    end
    TrafficSignalIndices=knnsearch([EgoDataByDist(i).Latitude' EgoDataByDist(i).Longitude'],IntersectionGPS);
%     assignin('base','TrafficSignalIndices',TrafficSignalIndices)
%     assignin('base','InterpolatedTSP',InterpolatedTSP)
%     return
    %Interpolated V2I
    clear InterpolatedSS
%     assignin('base','oldTime',AllData(i).LatLon.oldTime)
%     assignin('base','Time',EgoDataByDist(i).Time)
%     assignin('base','InterpolatedTSP',InterpolatedTSP)
%     assignin('base','InterpolatedTSP',InterpolatedTSP)
    for j=1:1:numel(Segments) %pulling for the segments
        for k=1:1:numel(AllData(i).InterpolatedData.data)
            if regexp(AllData(i).InterpolatedData.data(k).name,Segments{j})
                if regexp(AllData(i).InterpolatedData.data(k).name,'SegmentSpeed')
                    tempV2I=AllData(i).InterpolatedData.data(k).data;
                    break
                end
            end
        end
%         disp(j)
%         assignin('base','tempV2I',tempV2I)
        InterpolatedSS(j,:)=interp1(AllData(i).LatLon.oldTime,tempV2I,EgoDataByDist(i).Time); %interpolating lat
    end
    
    %interpolating ADAS
    for j=1:1:numel(ADASIndices(i).az)
        k=ADASIndices(i).az(j);
        AllData(i).InterpolatedData.data(k).data=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(k).data,EgoDataByDist(i).Time);
    end
    for j=1:1:numel(ADASIndices(i).rn)
        k=ADASIndices(i).rn(j);
        AllData(i).InterpolatedData.data(k).data=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(k).data,EgoDataByDist(i).Time);
    end
    for j=1:1:numel(ADASIndices(i).ts)
        k=ADASIndices(i).ts(j);
        if k~=0 
            AllData(i).InterpolatedData.data(k).data=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(k).data,EgoDataByDist(i).Time,'nearest');
        else
            newIndex=numel(AllData(i).InterpolatedData.data)+1;
            ADASIndices(i).ts(j)=newIndex;
            AllData(i).InterpolatedData.data(newIndex).data=zeros(1,numel(EgoDataByDist(i).Time));
        end
    end
    for j=1:1:numel(ADASIndices(i).bk)
        k=ADASIndices(i).bk(j);
        if k~=0
            AllData(i).InterpolatedData.data(k).data=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(k).data,EgoDataByDist(i).Time,'nearest');
        else
            newIndex=numel(AllData(i).InterpolatedData.data)+1;
            ADASIndices(i).bk(j)=newIndex;
            AllData(i).InterpolatedData.data(newIndex).data=zeros(1,numel(EgoDataByDist(i).Time));
        end
    end
    assignin('base','ADASIndices1',ADASIndices);
%     return
    
    
    %Assigning
    k=1;
    tic
    for j=1:1:numel(EgoDataByDist(i).Time)
%         disp([j k])
        [EgoDataByDist(i),k]=AssignTrafficSignals(EgoDataByDist(i),TrafficSignalIndices,InterpolatedTSP,j,k,numLights);
%         disp([k])
        [EgoDataByDist(i),k]=AssignV2ISegments(EgoDataByDist(i),TrafficSignalIndices,InterpolatedSS,j,k);
%         disp([k])
        [EgoDataByDist(i)]=AssignADAS(EgoDataByDist(i),AllData(i).InterpolatedData,j,ADASIndices(i));
%         disp([k])
        [EgoDataByDist(i).V2V(j).meanSpeed,EgoDataByDist(i).V2V(j).sigmaSpeed]=AssignV2V(i,AllData,j);
        if rem(j,1000)==0
            fprintf('Processing Index %i\n',j)
        end
%         if j==25
%             break
%         end
    end
    disp(toc)
%     if i>=2
%         break
%     end
end
end