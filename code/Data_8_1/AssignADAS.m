function [EgoDataByDist]=AssignADAS(EgoDataByDist,InterpolatedData,j,ADASIndices)
weightedDistances=ones(1,numel(ADASIndices.dx))*10^6;
for l=1:1:numel(weightedDistances)
    if InterpolatedData.data(ADASIndices.dx(l)).data(j)>.5
    weightedDistances(l)=sqrt(InterpolatedData.data(ADASIndices.dx(l)).data(j)^2+...
        5*InterpolatedData.data(ADASIndices.dy(l)).data(j)^2);
    end
end
[~,minInd]=min(weightedDistances);
EgoDataByDist.LV(j).dx=InterpolatedData.data(ADASIndices.dx(minInd)).data(j);
EgoDataByDist.LV(j).dy=InterpolatedData.data(ADASIndices.dy(minInd)).data(j);
EgoDataByDist.LV(j).vx=InterpolatedData.data(ADASIndices.vx(minInd)).data(j);
end