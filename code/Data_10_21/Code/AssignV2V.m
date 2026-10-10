function [meanSpeed,sigmaSpeed]=AssignV2V(i,AllData,j)
speed=zeros(1,numel(AllData));
for k=1:1:numel(speed)
    speed(k)=interp1(AllData(k).LatLon.dist,AllData(k).LatLon.speed,AllData(i).LatLon.dist(j));
end
meanSpeed=mean(speed(~isnan(speed)));
sigmaSpeed=std(speed(~isnan(speed)));
end