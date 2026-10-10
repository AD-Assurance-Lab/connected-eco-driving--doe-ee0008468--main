function [EgoDataByDist]=GenerateDataStruct(AllData,intersections,IntersectionGPS,ADASIndices,Segments,numLights,EGOIndices)
EgoDataByDist=struct('time',[],'latitude',[],'longitude',[],'distance',[],'speed',[],'altitude',[],'bearing',[],'EngineLoad',[],'EngineSpeed',[],'ThrottlePos',[],'TSP',[],'V2I',[],'V2V',[],'LV',[]);
for i=1:1:numel(AllData)
    fprintf('Processing Lap %i\n',i)
    %% Making the structure
    EgoDataByDist(i).time=AllData(i).LatLon.time;
    EgoDataByDist(i).latitude=AllData(i).LatLon.lat;
    EgoDataByDist(i).longitude=AllData(i).LatLon.lon;
    EgoDataByDist(i).distance=AllData(i).LatLon.dist;
    EgoDataByDist(i).speed=AllData(i).LatLon.speed;
    EgoDataByDist(i).altitude=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.altitude).data,EgoDataByDist(i).time);
    EgoDataByDist(i).bearing=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.bearing).data,EgoDataByDist(i).time);
    EgoDataByDist(i).EngineLoad=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.EngineLoad).data,EgoDataByDist(i).time);
    EgoDataByDist(i).EngineSpeed=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.EngineSpeed).data,EgoDataByDist(i).time);
    EgoDataByDist(i).ThrottlePos=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(EGOIndices.ThrottlePos).data,EgoDataByDist(i).time);
    EgoDataByDist(i).TSP=struct('indices',[],'distances',[],'phases',[]);
    EgoDataByDist(i).V2I=struct('index',[],'speed',[],'distanceRemaining',[]);
    EgoDataByDist(i).V2V=struct('meanSpeed',[]);
    EgoDataByDist(i).LV=struct('dx',[],'dy',[],'vx',[]);
    
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
        InterpolatedTSP(j,:)=interp1(AllData(i).LatLon.oldTime,tempPhases,EgoDataByDist(i).time,'nearest'); %interpolating lat
    end
    TrafficSignalIndices=knnsearch([EgoDataByDist(i).latitude' EgoDataByDist(i).longitude'],IntersectionGPS);
    
    %Interpolated V2I
    clear InterpolatedV2I
    for j=1:1:numel(Segments) %pulling for the segments
        for k=1:1:numel(AllData(i).InterpolatedData.data)
            if regexp(AllData(i).InterpolatedData.data(k).name,Segments{j})
                if regexp(AllData(i).InterpolatedData.data(k).name,'SegmentSpeed')
                    tempV2I=AllData(i).InterpolatedData.data(k).data;
                    break
                end
            end
        end
        InterpolatedV2I(j,:)=interp1(AllData(i).LatLon.oldTime,tempV2I,EgoDataByDist(i).time); %interpolating lat
    end
    
    %interpolating ADAS
    for j=[ADASIndices.dx ADASIndices.dy ADASIndices.vx]
        AllData(i).InterpolatedData.data(j).data=interp1(AllData(i).LatLon.oldTime,AllData(i).InterpolatedData.data(j).data,EgoDataByDist(i).time);
    end
    
    %Assigning
    k=1;
    tic
    for j=1:1:numel(EgoDataByDist(i).time)
        [EgoDataByDist(i),k]=AssignTrafficSignals(EgoDataByDist(i),TrafficSignalIndices,InterpolatedTSP,j,k,numLights);
        [EgoDataByDist(i),k]=AssignV2ISegments(EgoDataByDist(i),TrafficSignalIndices,InterpolatedV2I,j,k);
        [EgoDataByDist(i)]=AssignADAS(EgoDataByDist(i),AllData(i).InterpolatedData,j,ADASIndices);
%         disp([i,j])
        EgoDataByDist(i).V2V(j).meanSpeed=AssignV2V(i,AllData,j);
        if rem(j,1000)==0
            fprintf('Processing Index %i\n',j)
        end
%         if j==500
%             break
%         end
    end
    disp(toc)
end
end