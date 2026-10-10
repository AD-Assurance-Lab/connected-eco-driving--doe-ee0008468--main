for i=1:1:numel(Objects)
    x(i)=Objects{i}.Measurement(1);
    y(i)=Objects{i}.Measurement(2);
end
figure
scatter(x,y)
%%
for i=1:1:numel(Objects)
    x(i)=Objects{i}.SensorIndex(1);
end
figure
plot(x)
for i=1:1:numel(Objects)
    x(i)=Objects{i}.ObjectClassID(1);
end
figure
plot(x)