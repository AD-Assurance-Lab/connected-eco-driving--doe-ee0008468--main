function [EgoDataByDist,j]=AssignV2ISegments(EgoDataByDist,TrafficSignalIndices,InterpolatedV2I,i,j)
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
if j<=6 % 2. MulberryCollegeToShields
    EgoDataByDist(i).V2I.index=2;
    endIndex=TrafficSignalIndices(6);
    EgoDataByDist(i).V2I.speed=InterpolatedV2I(EgoDataByDist(i).V2I.index,i);
    EgoDataByDist(i).V2I.distanceRemaining=lldistkm([EgoDataByDist(i).latitude,EgoDataByDist(i).longitude],[EgoDataByDist(endIndex).latitude,EgoDataByDist(endIndex).longitude])*1000;
elseif j>6 && j<=12 % 4. ShieldsMulberryToProspect
    EgoDataByDist(i).V2I.index=4;
    endIndex=TrafficSignalIndices(12);
    EgoDataByDist(i).V2I.speed=InterpolatedV2I(EgoDataByDist(i).V2I.index,i);
    EgoDataByDist(i).V2I.distanceRemaining=lldistkm([EgoDataByDist(i).latitude,EgoDataByDist(i).longitude],[EgoDataByDist(endIndex).latitude,EgoDataByDist(endIndex).longitude])*1000;
elseif j>12 && j<=15 % 5. ShieldsProspectToDrake
    EgoDataByDist(i).V2I.index=5;
    endIndex=TrafficSignalIndices(15);
    EgoDataByDist(i).V2I.speed=InterpolatedV2I(EgoDataByDist(i).V2I.index,i);
    EgoDataByDist(i).V2I.distanceRemaining=lldistkm([EgoDataByDist(i).latitude,EgoDataByDist(i).longitude],[EgoDataByDist(endIndex).latitude,EgoDataByDist(endIndex).longitude])*1000;
elseif j>15 && j<=18 % 3. ProspectShieldsToCollege
    EgoDataByDist(i).V2I.index=3;
    endIndex=TrafficSignalIndices(18);
    EgoDataByDist(i).V2I.speed=InterpolatedV2I(EgoDataByDist(i).V2I.index,i);
    EgoDataByDist(i).V2I.distanceRemaining=lldistkm([EgoDataByDist(i).latitude,EgoDataByDist(i).longitude],[EgoDataByDist(endIndex).latitude,EgoDataByDist(endIndex).longitude])*1000;
elseif j>18 && j<=22 % 1. CollegeProspectToMulberry
    EgoDataByDist(i).V2I.index=1;
    endIndex=TrafficSignalIndices(22);
    EgoDataByDist(i).V2I.speed=InterpolatedV2I(EgoDataByDist(i).V2I.index,i);
    EgoDataByDist(i).V2I.distanceRemaining=lldistkm([EgoDataByDist(i).latitude,EgoDataByDist(i).longitude],[EgoDataByDist(endIndex).latitude,EgoDataByDist(endIndex).longitude])*1000;
end