function [EgoDataByDist,j]=AssignADAS(EgoDataByDist,interpolatedADAS,i,j,indices)
%% Description
% 5. ADAS:
% 	Lead vehicle dx, dy, and vx
% 	other vehicles dx, dy, and vx
% 	(remember that all data with dx<=.5 is spurious)
%%
adasInfo = zeros(numel(indices.dx),3);

smallestDist=100000000;
ind=0;
for k = 1:1:numel(indices.dx)
    if interpolatedADAS.dx(k,i)>=.05
        dist=sqrt(interpolatedADAS.dx(k,i)^2+5*interpolatedADAS.dy(k,i)^2);
        if dist<smallestDist
            smallestDist=dist;
            ind=k;
        end
    end
%     adasInfo(k,:) = [Lap2InterpolatedData.data(indices.dx(k)).data(i) Lap2InterpolatedData.data(indices.dy(k)).data(i) Lap2InterpolatedData.data(indices.vx(k)).data(i)];
end
EgoDataByDist(i).LV.dx=interpolatedADAS.dx(ind,i);
EgoDataByDist(i).LV.dy=interpolatedADAS.dy(ind,i);
EgoDataByDist(i).LV.vx=interpolatedADAS.vx(ind,i);
% = [Lap2InterpolatedData.data(indices.dx(k)).data(i) Lap2InterpolatedData.data(indices.dy(k)).data(i) Lap2InterpolatedData.data(indices.vx(k)).data(i)];



end


