%% Data Animation
figure
hold on
plot(InterpolatedData(38).data,InterpolatedData(39).data,'b')
plot(InterpolatedData(46).data,InterpolatedData(47).data,'r')
plot(InterpolatedData(54).data,InterpolatedData(55).data,'k')
%%
for i=1:1:numel(InterpolatedData.time)
