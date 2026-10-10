clc; clear all; close all;
%% Data Import
import=struct('data',[],'text',[]);
[import(1).data,import(1).text]=xlsread('D01.csv'); %V2V data from D01 5/15/2019
[import(2).data,import(2).text]=xlsread('D02.csv'); %V2V data from D01 5/15/2019
output=struct('name','','data',[]);
output(1).name='V2V_1_D01';
output(1).data=ConcatenateDrivingData(import(1),1,8,9,2,3,57);
output(2).name='V2V_2_D02';
output(2).data=ConcatenateDrivingData(import(1),1,8,9,2,3,5);
% %% Time Vector Generation
% timeCells=data(1).txt(2:end,1)';
% time=zeros(1,numel(timeCells));
% for i=1:1:numel(timeCells)
% %     i
%     c=timeCells(i);
%     s=c{:};
%     if ~strcmpi(s,'GPS Time')
%     timeString=s(12:19);
%     H=str2double(s(12:13));
%     M=str2double(s(15:16));
%     S=str2double(s(18:19));
%     time(i)=H*3600+M*60+S;
%     end
% end
% %% Data Import
% data(1).time=time;
% data(1).GX=data(:,8)';
% data(1).GY=data(:,9)';
% data(1).Longitude=data(:,2);
% data(1).Latitude=data(:,3);
% data(1).GPSSpeed=data(:,57);
% data(1).OBDSpeed=data(:,58);
% %% Verification Plotting
% figure
% plot3(Longitude,Latitude,time)
