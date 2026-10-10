function [outStruct]=QueryTestData(inStruct,samplingTimes,defaultMethod,condition)
% This function takes as inputs:
%
% a test data structure with <n> channels in
% the format:
% .name - string which is a legal matlab variable name
% .data - [[<m> by 2 double]];
% 
% a [1 by <l>] vector of sampling times
%
% a default MATLAB interpolation method as a string
%
% This function outputs an <n> element structure with the same channels of
% the format:
% .name - string which is a legal matlab variable name
% .data - [<l> by 1 double];
% with a unified time index
%
% The default interpolation method used is linear but this can be modified
% by using a condition input.
% The condition input must be of the type DataInterpCondition.
%% Method
outStruct=inStruct;
if ~isempty(condition)
    for i=1:1:numel(outStruct)
        method=defaultMethod;
        for j=1:1:numel(condition)
            method=condition(j).Check(outStruct(i).name,defaultMethod);
        end
%         disp(i)
        indices=find(~isnan(inStruct(i).data(:,1)));
%         disp([1 find(isnan(inStruct(i).data(:,1)))])
        dataTemp=inStruct(i).data(indices,2);
        timeTemp=inStruct(i).data(indices,1);
%         disp([1 find(isnan(dataTemp))])
%         disp('a')
%         timeTemp
        [~,indices1]=unique(timeTemp);
        dataTemp=dataTemp(indices1);
        timeTemp=timeTemp(indices1);
        outStruct(i).data=interp1(timeTemp,dataTemp,samplingTimes,method);
    end
else
    for i=1:1:numel(outStruct)
        method=defaultMethod;
        indices=find(~isnan(inStruct(i).data(:,1)));
        dataTemp=inStruct(i).data(indices,2);
        timeTemp=inStruct(i).data(indices,1);
        [~,indices1]=unique(timeTemp);
        dataTemp=dataTemp(indices1);
        timeTemp=timeTemp(indices1);
        disp(find(isnan(dataTemp)))
        outStruct(i).data=interp1(timeTemp,dataTemp,samplingTimes,method);
    end
end