%% Calling the function for multiple intersections
% Add loop here?


%addpath(genpath(pwd))

%  Run on first run to load file. 
clear
[~,~,raw]=xlsread('TrafficSignalLocations.xlsx');
[~,~,raw2]=xlsread('College_And.xlsx');
%% 

street1 = raw2(1,1) %'College';
street1 = char(street1);
street2 = raw2(2,1)%'Horsetooth';
street3 = raw2(3,1) %'Monroe';
street2 = char(street2);
street3 = char(street3);


intersections=[{street1},{street2};{street1},{street3}]; %pair of cells
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

% Need to record this in a unique name
%%
j = numel(raw2)


for k = 2:j-1   %Skip 1 as that's the through street (College in this case)
    street1 = char(raw2(1,1)) %'College';
    %street1 = char(street1);
    street2 = char(raw2(k,1))%'Horsetooth';
    street3 = char(raw2(k+1,1)) %'Monroe';
    %street2 = char(street2);
    %street3 = char(street3);


    intersections=[{street1},{street2};{street1},{street3}]; %pair of cells
        for i=1:1:numel(intersections(:,1)) %pulling for the intersections
        [latlon(i,:)]=PullTrafficSignalLatLon(string(intersections{i,1}),string(intersections{i,2}),raw);
        end
    latlon
    
    dkm=lldistkm(latlon(1,:),latlon(2,:)); %distance in kilometers
    intPoints=[0:1:dkm*1000]; %all of the distances between 0 and dkm
    sectionLat=interp1([0,dkm*1000],[latlon(1,1),latlon(2,1)],intPoints); %getting lat for the int points
    sectionLon=interp1([0,dkm*1000],[latlon(1,2),latlon(2,2)],intPoints); %getting lon for the int points
    
    sectionLatLon=[sectionLat;sectionLon]'; %combining into latlons
    
    % How would I code this up?
    Name =  sectionLatLon    
    % Need to save as new name each time
    
    
    k = k+1;
end
