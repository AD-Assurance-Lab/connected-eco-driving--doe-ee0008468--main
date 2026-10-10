%% Data Animation
figure
hold on
plot(InterpolatedData.data(38).data,InterpolatedData.data(39).data,'b')
plot(InterpolatedData.data(46).data,InterpolatedData.data(47).data,'r')
plot(InterpolatedData.data(54).data,InterpolatedData.data(55).data,'k')
title('GPS Traces')
xlabel('Longitude (deg)')
ylabel('Latitude (deg)')
legend('D01','D02','D04')
%%
% for i=1:1:numel(InterpolatedData.time)
