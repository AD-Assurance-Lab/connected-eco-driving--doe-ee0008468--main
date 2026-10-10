function [visionObjects]=MobileyeToASDT(InterpolatedData,Indices)
if nargin<2
    Indices=struct('DX',[],'DY',[],'VX',[],'W',[]);
    for i=1:1:numel(InterpolatedData.data)
        if regexp(InterpolatedData.data(i).name,'ADAS')
            if regexp(InterpolatedData.data(i).name,'Obstacle_Pos_X')
                Indices.DX=[Indices.DX i];
            elseif regexp(InterpolatedData.data(i).name,'Obstacle_Pos_Y')
                Indices.DY=[Indices.DY i];
            elseif regexp(InterpolatedData.data(i).name,'Obstacle_Rel_Vel')
                Indices.VX=[Indices.VX i];
            elseif regexp(InterpolatedData.data(i).name,'Obstacle_Width')
                Indices.W=[Indices.W i];
            end
        end
    end
end
visionObjects=struct('timeStamp',[],'object',[],'numObjects',[]);
for i=1:1:numel(InterpolatedData.time)
    visionObjects(i).timeStamp=InterpolatedData.time(i);
    object=struct('id',[],'classification',[],'position',[],'velocity',[],'size',[]);
    for j=1:1:numel(Indices.DX)
        object(j).id=j;
        object(j).classification=5;
        object(j).position=[InterpolatedData.data(Indices.DX(j)).data(i),...
            InterpolatedData.data(Indices.DY(j)).data(i),0];
        object(j).velocity=[InterpolatedData.data(Indices.VX(j)).data(i),0,0];
        object(j).size=[0,InterpolatedData.data(Indices.W(j)).data(i),0];
        object(j).position(isnan(object(j).position))=0;
        object(j).velocity(isnan(object(j).velocity))=0;
        object(j).size(isnan(object(j).size))=0;
    end
    visionObjects(i).object=object;
    visionObjects(i).numObjects=j;
end