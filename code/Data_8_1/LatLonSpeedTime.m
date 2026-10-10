%% Figure of route by lat, lon, time colored by speed
figure; 
scatter3(InterpolatedData.data(42).data,InterpolatedData.data(43).data,InterpolatedData.time,10,InterpolatedData.data(44).data/max(InterpolatedData.data(44).data))
%% Figure of route by lat, lon, and data index
figure; 
scatter3(InterpolatedData.data(42).data,InterpolatedData.data(43).data,[1:1:numel(InterpolatedData.time)],10)
