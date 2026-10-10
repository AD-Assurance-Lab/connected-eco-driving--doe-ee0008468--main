function [dataOut]=GeneratePhaseEncoding(File)
[~,~,raw]=xlsread(File); %reading the excel file in as cells
raw=raw(:,1:2); %cutting out the headers and last line (comes in as NaNs)
for i=1:1:numel(raw(:,1)) %changing the signal names to acceptable MATLAB variable names
    str=raw{i,1};
    str=strrep(str,' ','_');
    str=strrep(str,'(','');
    str=strrep(str,')','');
    str=strrep(str,'&','');
    str=strrep(str,'__','_');
    raw(i,1)={str};
end
dataOut=raw;