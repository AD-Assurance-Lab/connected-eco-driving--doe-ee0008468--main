clc; close all
load('InterpolatedData_1s');
figure
hold on
j=0;
for i=1:1:numel(InterpolatedData.data)
    if regexp(InterpolatedData.data(i).name,'ADAS')
        if regexp(InterpolatedData.data(i).name,'Radar1_Obj')
            if regexp(InterpolatedData.data(i).name(end-2:end),'_dx')
                j=j+1;
                disp(j)
                disp(InterpolatedData.data(i).name)
                scatter(InterpolatedData.data(i).data,InterpolatedData.data(i-1).data,1,'b')
            end
        end
    end
end
for i=1:1:numel(InterpolatedData.data)
    if regexp(InterpolatedData.data(i).name,'ADAS')
        if regexp(InterpolatedData.data(i).name,'Radar1_Target')
            if regexp(InterpolatedData.data(i).name(end-2:end),'_dx')
                j=j+1;
                disp(j)
                disp(InterpolatedData.data(i).name)
                scatter(InterpolatedData.data(i).data,InterpolatedData.data(i-1).data,1,'r')
            end
        end
    end
end
axis equal
%%
figure
for i=1:1:numel(InterpolatedData.data)
    if regexp(InterpolatedData.data(i).name,'ADAS')
        if regexp(InterpolatedData.data(i).name,'Radar1_Obj')
            if regexp(InterpolatedData.data(i).name(end-2:end),'_dx')
                j=j+1;
                disp(j)
                disp(InterpolatedData.data(i).name)
                scatter(InterpolatedData.data(i).data,InterpolatedData.data(i-1).data,1,'b')
            end
        end
    end
end
for i=1:1:numel(InterpolatedData.data)
    if regexp(InterpolatedData.data(i).name,'ADAS')
        if regexp(InterpolatedData.data(i).name,'Radar1_Target')
            if regexp(InterpolatedData.data(i).name(end-2:end),'_dx')
                j=j+1;
                disp(j)
                disp(InterpolatedData.data(i).name)
                scatter(InterpolatedData.data(i).data,InterpolatedData.data(i-1).data,1,'r')
            end
        end
    end
end
for i=1:1:numel(InterpolatedData.data)
    if regexp(InterpolatedData.data(i).name,'ADAS')
        if regexp(InterpolatedData.data(i).name,'Obstacle_Pos_X')
            j=j+1;
            disp(j)
            disp(InterpolatedData.data(i).name)
            scatter(InterpolatedData.data(i).data,InterpolatedData.data(i-1).data,1,'k')
        end
    end
end
axis equal
%%
figure
hold on
j=0;
colormap('cool')
for i=1:1:numel(InterpolatedData.data)
    if regexp(InterpolatedData.data(i).name,'ADAS')
        if regexp(InterpolatedData.data(i).name,'Radar1_Obj')
            if regexp(InterpolatedData.data(i).name(end-2:end),'_dx')
                j=j+1;
                disp(j)
                disp(InterpolatedData.data(i).name)
                scatter(InterpolatedData.data(i).data,InterpolatedData.data(i-1).data,10,InterpolatedData.data(i+14).data/max(InterpolatedData.data(i+14).data))
            end
        end
    end
end