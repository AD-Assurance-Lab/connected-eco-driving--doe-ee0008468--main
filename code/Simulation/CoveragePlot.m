function CoveragePlot(scenario,radar,vision)
% Create bird's eye plotter
% figure
bep = birdsEyePlot('XLimits',[-100 100],'YLimits',[-50 50]);

% Create coverage area plotter
cap{1} = coverageAreaPlotter(bep,'FaceColor','blue','EdgeColor','blue');
cap{2} = coverageAreaPlotter(bep,'FaceColor','red','EdgeColor','red');

% Plot coverage area
j=0;
for i=1:1:numel(radar)
    j=j+1;
    cap{j} = coverageAreaPlotter(bep,'FaceColor','red','EdgeColor','red');
    plotCoverageArea(cap{j},radar{i}.Sensor.SensorLocation,radar{i}.Sensor.MaxRange,radar{i}.Sensor.Yaw,radar{i}.Sensor.FieldOfView(1));
end
for i=1:1:numel(vision)
    j=j+1;
     cap{j} = coverageAreaPlotter(bep,'FaceColor','blue','EdgeColor','blue');
     plotCoverageArea(cap{j},vision{i}.Sensor.SensorLocation,vision{i}.Sensor.MaxRange,vision{i}.Sensor.Yaw,vision{i}.Sensor.FieldOfView(1));
end
end
