%% Proof of concept script
%addpath(genpath(pwd))
[~,~,raw]=xlsread('TrafficSignalLocations.xlsx'); %traffic signal locations

%Inputs of street names
str1='College';
str2='Drake';
%looped on all data rows
for i=1:1:numel(raw(:,1))
    c=raw(i,2); s=c{:}; %pulled the name as a cell and turned into a string
    if regexp(s,str1) %used regext to compare it to the name at the top
        if regexp(s,str2) %and again for the second name so it only outputs if both match
            latlon=[raw{i,5},raw{i,4}]; %if they both match I output LatLon
        end
    end
end
%% Using the function
[~,~,raw]=xlsread('TrafficSignalLocations.xlsx'); %calling it as a function
[latlon]=PullTrafficSignalLatLon('College','Drake',raw);
%% Calling the function for multiple intersections
intersections=[{'College'},{'Mulberry'};{'College'},{'Prospect'}]; %pair of cells
for i=1:1:numel(intersections(:,1)) %pulling for the intersections
    [latlon(i,:)]=PullTrafficSignalLatLon(string(intersections{i,1}),string(intersections{i,2}),raw);
end
latlon
%% Generating the latlon vector for the span of two intersections
dkm=lldistkm(latlon(1,:),latlon(2,:)); %distance in kilometers
intPoints=[0:1:dkm*1000]; %all of the distances between 0 and dkm
sectionLat=interp1([0,dkm*1000],[latlon(1,1),latlon(2,1)],intPoints); %getting lat for the int points
sectionLon=interp1([0,dkm*1000],[latlon(1,2),latlon(2,2)],intPoints); %getting lon for the int points
sectionLatLon=[sectionLat;sectionLon]'; %combining into latlons
%% For centre road
[~,~,raw2]=xlsread('tomtom_network_w_grade.csv');
[CentreLatLon]=PullGPSFromTomTomDataByRoad(raw2,'Centre'); %latlons in the wrong order
CentreLatLon=CentreLatLon'; %transpose
CentreLatLon=[CentreLatLon(:,2),CentreLatLon(:,1)]; %flipping the column order
%%
figure
hold on
plot(sectionLatLon(:,2),sectionLatLon(:,1),'ob');
plot(CentreLatLon(:,2),CentreLatLon(:,1),'or');
%%
badPoints=[]; j=0;
for i=1:1:numel(CentreLatLon(:,1))
    lat=CentreLatLon(i,1);
    lon=CentreLatLon(i,2);
    if lon<-105.0848 && lon>-105.0864
        if lat>40.5645 && lat<40.567
            j=j+1;
            badPoints(j)=i;
        end
    end
end
indices=1:1:numel(CentreLatLon(:,1));
indices(badPoints)=0;
CentreLatLon=CentreLatLon(indices~=0,:);
plot(CentreLatLon(:,2),CentreLatLon(:,1),'ok');