function [EgoDataByDist]=AssignADAS(EgoDataByDist,InterpolatedData,j,ADASIndices)
weightedDistances=ones(1,numel(ADASIndices.az))*10^6;
dx=ones(1,numel(weightedDistances))*10^6;
dy=ones(1,numel(weightedDistances))*10^6;
for l=1:1:numel(weightedDistances)
    dx(l)=InterpolatedData.data(ADASIndices.rn(l)).data(j).*cosd(InterpolatedData.data(ADASIndices.az(l)).data(j));
    dy(l)=InterpolatedData.data(ADASIndices.rn(l)).data(j).*sind(InterpolatedData.data(ADASIndices.az(l)).data(j));
    if dx(l)>.5
    weightedDistances(l)=sqrt(dx(l)^2+(5*dy(l))^2);
    end
end
[~,minInd]=min(weightedDistances);
% disp([j minInd])
EgoDataByDist.LV(j).dx=dx(minInd);
EgoDataByDist.LV(j).dy=dy(minInd);
% EgoDataByDist.LV(j).TrnSig=InterpolatedData.data(ADASIndices.ts(minInd)).data(j);
% EgoDataByDist.LV(j).BrkLgt=InterpolatedData.data(ADASIndices.bk(minInd)).data(j);
end