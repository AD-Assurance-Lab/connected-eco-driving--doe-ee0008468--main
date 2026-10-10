function [interpDataOut]=CutInterpData(interpDataIn,lapIndices)
interpDataOut=struct('data',[],'time',[]);
interpDataOut.time=interpDataIn.time(lapIndices(1):lapIndices(2));
for i=1:1:numel(interpDataIn.data)
    interpDataOut.data(i).name=interpDataIn.data(i).name;
    interpDataOut.data(i).data=interpDataIn.data(i).data(lapIndices(1):lapIndices(2));
end
end