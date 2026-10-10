clc; clear all; close all;
%%
[data,txt]=xlsread('D03.csv');
%%
GX=data(:,8)';
GY=data(:,9)';
Time=data(:,1)';
%%
figure
plot(Time)
reset=find(Time==min(Time));
maxTime=max(Time);
FixedTime=[Time(1:reset-1) Time(reset:end)+maxTime];
hold on
plot(FixedTime,'r')
start=34*60+1.7;
FixedTime=FixedTime*(3600-start)/maxTime;
figure
plot(FixedTime)
%%
figure
plot(FixedTime,smooth(GX,50))
%%
figure
scatter(smooth(GX,50),smooth(GY,50))
%%
GX1=smooth(GX,50); GY1=smooth(GY,50);
VX=zeros(1,numel(GX)); VY=zeros(1,numel(GY));
X=zeros(1,numel(GX)); Y=zeros(1,numel(GY));
for i=2:1:numel(FixedTime)
    VX(i)=VX(i-1)+GX1(i)*(FixedTime(i)-FixedTime(i-1));
    VY(i)=VY(i-1)+GY1(i)*(FixedTime(i)-FixedTime(i-1));
    X(i)=X(i-1)+VX(i)*(FixedTime(i)-FixedTime(i-1));
    Y(i)=Y(i-1)+VY(i)*(FixedTime(i)-FixedTime(i-1));
end
figure
plot(FixedTime,VX)