clc; clear all; close all;
%% Data Import
import=struct('data',[],'text',[]);
[~,sheets]=xlsfinfo('TrafficSignals.xlsx');
for i=1:1:numel(sheets)
    [import(i).data,import(i).text]=xlsread('TrafficSignals.xlsx',i);
end
output=struct('name','','data',[]);
for i=2:1:numel(sheets)
    c=sheets(i);
    s=c{:};
    output(i-1).name=s;
    output(i-1).data=ConcatenateTSPData(import(i));
end