function [EgoDataByDist,k]=AssignV2ISegments(EgoDataByDist,TrafficSignalIndices,InterpolatedSS,j,k)
%% Description
% 3. Segments (SS):
% 	Currnet segment index
% 	current segment speed
% 	dist along segment (relative to segment) HEURISTIC TIME!
% 1. CollegeProspectToMulberry
% 2. MulberryCollegeToShields
% 3. ProspectShieldsToCollege
% 4. ShieldsMulberryToProspect
% 5. ShieldsProspectToDrake
if k<=6 % 2. MulberryCollegeToShields
    EgoDataByDist.SS(j).index=2;
    endIndex=TrafficSignalIndices(6);
    EgoDataByDist.SS(j).speed=InterpolatedSS(EgoDataByDist.SS(j).index,j);
    EgoDataByDist.SS(j).distanceRemaining=lldistkm([EgoDataByDist.Latitude(j),EgoDataByDist.Longitude(j)],[EgoDataByDist.Latitude(endIndex),EgoDataByDist.Longitude(endIndex)])*1000;
elseif k>6 && k<=12 % 4. ShieldsMulberryToProspect
    EgoDataByDist.SS(j).index=4;
    endIndex=TrafficSignalIndices(12);
    EgoDataByDist.SS(j).speed=InterpolatedSS(EgoDataByDist.SS(j).index,j);
    EgoDataByDist.SS(j).distanceRemaining=lldistkm([EgoDataByDist.Latitude(j),EgoDataByDist.Longitude(j)],[EgoDataByDist.Latitude(endIndex),EgoDataByDist.Longitude(endIndex)])*1000;
elseif k>12 && k<=16 % 3. ProspectShieldsToCollege
    EgoDataByDist.SS(j).index=3;
    endIndex=TrafficSignalIndices(16);
    EgoDataByDist.SS(j).speed=InterpolatedSS(EgoDataByDist.SS(j).index,j);
    EgoDataByDist.SS(j).distanceRemaining=lldistkm([EgoDataByDist.Latitude(j),EgoDataByDist.Longitude(j)],[EgoDataByDist.Latitude(endIndex),EgoDataByDist.Longitude(endIndex)])*1000;
elseif k>16 && k<=20 % 1. CollegeProspectToMulberry
    EgoDataByDist.SS(j).index=1;
    endIndex=TrafficSignalIndices(20);
    EgoDataByDist.SS(j).speed=InterpolatedSS(EgoDataByDist.SS(j).index,j);
    EgoDataByDist.SS(j).distanceRemaining=lldistkm([EgoDataByDist.Latitude(j),EgoDataByDist.Longitude(j)],[EgoDataByDist.Latitude(endIndex),EgoDataByDist.Longitude(endIndex)])*1000;
end