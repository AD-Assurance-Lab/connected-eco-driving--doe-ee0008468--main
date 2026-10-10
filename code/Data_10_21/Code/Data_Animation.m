%% Data Animation
figure
hold on
plot3(InterpolatedData.data(33).data,InterpolatedData.data(32).data,InterpolatedData.data(35).data,'b')
plot3(InterpolatedData.data(37).data,InterpolatedData.data(36).data,InterpolatedData.data(39).data,'r')
plot3(InterpolatedData.data(42).data,InterpolatedData.data(43).data,InterpolatedData.data(44).data,'k')
% plot(InterpolatedData.data(54).data,InterpolatedData.data(55).data,'k')
title('GPS Traces')
xlabel('Longitude (deg)')
ylabel('Latitude (deg)')
zlabel('Speed (kmh)')
legend('V2V1','V2V2','Ego')
%%
% for i=1:1:numel(InterpolatedData.time)
