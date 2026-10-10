function [EgoDataByDist]=AssignEGO(EgoDataByDist,InterpolatedData,j)
alt=interp1(
EgoDataByDist.EGO(j)=struct('altitude',[],'bearing',[],'EngineLoad',[],'EngineSpeed',[],'ThrottlePos',[]);