function [radarObjects]=RadarToASDT(InterpolatedData,Indices)
% if nargin<2
%     Indices=struct('DX',[],'DY',[],'DZ',[],'VX',[],'VY',[],'C',[]);
%     for i=1:1:numel(InterpolatedData.data)
%         if regexp(InterpolatedData.data(i).name,'ADAS')
%             if regexp(InterpolatedData.data(i).name,'Radar1_Obj')
%                 if regexp(InterpolatedData.data(i).name,'_dx$')
%                     Indices.DX=[Indices.DX i];
%                 elseif regexp(InterpolatedData.data(i).name,'_dy$')
%                     Indices.DY=[Indices.DY i];
%                 elseif regexp(InterpolatedData.data(i).name,'_dz$')
%                     Indices.DZ=[Indices.DZ i];
%                 elseif regexp(InterpolatedData.data(i).name,'_vx$')
%                     Indices.VX=[Indices.VX i];
%                 elseif regexp(InterpolatedData.data(i).name,'_vy$')
%                     Indices.VY=[Indices.VY i];
%                 elseif regexp(InterpolatedData.data(i).name,'_class$')
%                     Indices.C=[Indices.C i];
%                 end
%             end
%         end
%     end
% end
% assignin('base','Indices',Indices);
if nargin<2
    Indices=struct('DX',[],'DY',[],'DZ',[],'VX',[],'VY',[],'C',[]);
    for i=1:1:numel(InterpolatedData.data)
        if regexp(InterpolatedData.data(i).name,'ADAS')
            if regexp(InterpolatedData.data(i).name,'Radar1_Target')
                if regexp(InterpolatedData.data(i).name,'_dx$')
                    Indices.DX=[Indices.DX i];
                elseif regexp(InterpolatedData.data(i).name,'_dy$')
                    Indices.DY=[Indices.DY i];
                elseif regexp(InterpolatedData.data(i).name,'_dz$')
                    Indices.DZ=[Indices.DZ i];
                elseif regexp(InterpolatedData.data(i).name,'_vx$')
                    Indices.VX=[Indices.VX i];
                elseif regexp(InterpolatedData.data(i).name,'_vy$')
                    Indices.VY=[Indices.VY i];
                elseif regexp(InterpolatedData.data(i).name,'_cla$')
                    Indices.C=[Indices.C i];
                end
            end
        end
    end
end
assignin('base','Indices',Indices);
radarObjects=struct('timeStamp',[],'object',[],'numObjects',[]);
for i=1:1:numel(InterpolatedData.time)
    radarObjects(i).timeStamp=InterpolatedData.time(i);
    object=struct('id',[],'status',[],'position',[],'velocity',[],'amplitude',[],'rangeMode',[],'rangeRate',[]);
    for j=1:1:numel(Indices.DX)
        object(j).id=j;
        object(j).status=InterpolatedData.data(Indices.C(j)).data(i);
        object(j).position=[InterpolatedData.data(Indices.DX(j)).data(i),...
            InterpolatedData.data(Indices.DY(j)).data(i),...
            InterpolatedData.data(Indices.DZ(j)).data(i)];
        object(j).velocity=[InterpolatedData.data(Indices.VX(j)).data(i),...
            InterpolatedData.data(Indices.VY(j)).data(i),0];
        object(j).amplitude=0;
        object(j).rangeMode=0;
        object(j).rangeRate=0;
        object(j).position(isnan(object(j).position))=0;
        object(j).velocity(isnan(object(j).velocity))=0;
    end
    radarObjects(i).object=object;
    radarObjects(i).numObjects=j;
end