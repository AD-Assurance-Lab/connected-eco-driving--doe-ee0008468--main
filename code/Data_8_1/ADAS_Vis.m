load('InterpolatedData_8_1_10Hz_SF.mat')
x=[];
y=[];
vx=[];
for i=51:4:numel(InterpolatedData.data)
    x=[x InterpolatedData.data(i).data];
    y=[y InterpolatedData.data(i+1).data];
    vx=[vx InterpolatedData.data(i+2).data];
end
%%
figure
scatter(y,x,10,vx/max(vx));
colorbar;
axis equal
title('CSU Detections by Speed')
xlabel('dy [m]')
ylabel('dx [m]')
f=gcf;
a=gca;