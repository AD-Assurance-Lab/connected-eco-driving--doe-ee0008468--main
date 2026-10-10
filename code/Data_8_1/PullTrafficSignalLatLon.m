function [latlon]=PullTrafficSignalLatLon(street1,street2,trafficSignalLocations)
%Input strings!
%looped on all data rows
for i=1:1:numel(trafficSignalLocations(:,1))
    c=trafficSignalLocations(i,2); s=c{:}; %pulled the name as a cell and turned into a string
    if regexp(s,street1) %used regext to compare it to the name at the top
        if regexp(s,street2) %and again for the second name so it only outputs if both match
            latlon=[trafficSignalLocations{i,5},trafficSignalLocations{i,4}]; %if they both match I output LatLon
        end
    end
end