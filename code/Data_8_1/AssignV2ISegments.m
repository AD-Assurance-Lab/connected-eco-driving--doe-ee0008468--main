function [EgoDataByDist,k]=AssignV2ISegments(EgoDataByDist,TrafficSignalIndices,InterpolatedV2I,j,k)
%% Description
% 3. Segments (V2I):
% 	Currnet segment index
% 	current segment speed
% 	dist along segment (relative to segment) HEURISTIC TIME!
% 1. CollegeProspectToMulberry
% 2. MulberryCollegeToShields
% 3. ProspectShieldsToCollege
% 4. ShieldsMulberryToProspect
% 5. ShieldsProspectToDrake
if k<=6 % 2. MulberryCollegeToShields
    EgoDataByDist.V2I(j).index=2;
    endIndex=TrafficSignalIndices(6);
    EgoDataByDist.V2I(j).speed=InterpolatedV2I(EgoDataByDist.V2I(j).index,j);
    EgoDataByDist.V2I(j).distanceRemaining=lldistkm([EgoDataByDist.latitude(j),EgoDataByDist.longitude(j)],[EgoDataByDist.latitude(endIndex),EgoDataByDist.longitude(endIndex)])*1000;
elseif k>6 && k<=12 % 4. ShieldsMulberryToProspect
    EgoDataByDist.V2I(j).index=4;
    endIndex=TrafficSignalIndices(12);
    EgoDataByDist.V2I(j).speed=InterpolatedV2I(EgoDataByDist.V2I(j).index,j);
    EgoDataByDist.V2I(j).distanceRemaining=lldistkm([EgoDataByDist.latitude(j),EgoDataByDist.longitude(j)],[EgoDataByDist.latitude(endIndex),EgoDataByDist.longitude(endIndex)])*1000;
elseif k>12 && k<=15 % 5. ShieldsProspectToDrake
    EgoDataByDist.V2I(j).index=5;
    endIndex=TrafficSignalIndices(15);
    EgoDataByDist.V2I(j).speed=InterpolatedV2I(EgoDataByDist.V2I(j).index,j);
    EgoDataByDist.V2I(j).distanceRemaining=lldistkm([EgoDataByDist.latitude(j),EgoDataByDist.longitude(j)],[EgoDataByDist.latitude(endIndex),EgoDataByDist.longitude(endIndex)])*1000;
elseif k>15 && k<=18 % 3. ProspectShieldsToCollege
    EgoDataByDist.V2I(j).index=3;
    endIndex=TrafficSignalIndices(18);
    EgoDataByDist.V2I(j).speed=InterpolatedV2I(EgoDataByDist.V2I(j).index,j);
    EgoDataByDist.V2I(j).distanceRemaining=lldistkm([EgoDataByDist.latitude(j),EgoDataByDist.longitude(j)],[EgoDataByDist.latitude(endIndex),EgoDataByDist.longitude(endIndex)])*1000;
elseif k>18 && k<=22 % 1. CollegeProspectToMulberry
    EgoDataByDist.V2I(j).index=1;
    endIndex=TrafficSignalIndices(22);
    EgoDataByDist.V2I(j).speed=InterpolatedV2I(EgoDataByDist.V2I(j).index,j);
    EgoDataByDist.V2I(j).distanceRemaining=lldistkm([EgoDataByDist.latitude(j),EgoDataByDist.longitude(j)],[EgoDataByDist.latitude(endIndex),EgoDataByDist.longitude(endIndex)])*1000;
end