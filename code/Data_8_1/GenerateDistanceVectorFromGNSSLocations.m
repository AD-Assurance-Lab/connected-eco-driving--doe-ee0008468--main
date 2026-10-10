function [DistVector,CumDistVector]=GenerateDistanceVectorFromGNSSLocations(Lon,Lat)
% For inputs of a [<n>] vector of latitude and a [<n>] vector of longitude
% a [<n>] vector of the distances between the points and a [<n>] vector of
% the cumulative distances are produced (all distances in kilometers)
DistVector=zeros(1,numel(Lat));
CumDistVector=zeros(1,numel(Lat));
for i=2:1:numel(Lat)
    [dkm]=lldistkm([Lat(i-1),Lon(i-1)],[Lat(i),Lon(i)]);
    DistVector(i)=dkm;
    CumDistVector(i)=CumDistVector(i-1)+dkm;
end
end
    