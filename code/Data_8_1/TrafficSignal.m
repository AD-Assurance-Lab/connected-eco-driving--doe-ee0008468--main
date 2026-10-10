classdef TrafficSignal<handle
    %defines a traffic signal by its GNSS location pair and relays the 
    %signal's current phase in the forward direction of the route
    properties
        LAT %GNSS latitude
        LON %GNSS longitude
        TSP %Vector of signal phases by time
        CSP %Current signal phase
    end
    methods
        function obj=TrafficSignal(LAT,LON,TSP)
            if nargin>0
                obj.LAT=LAT;
                obj.LON=LON;
                obj.TSP=TSP;
            end
            obj.Populate();
        end
        function obj=Populate(obj)
            %placeholder for function which fills in non-input properties
        end
        function obj=Step(obj,ego)
            %placeholder for function which takes location and time from 
            %ego vehicle and updates object data
        end
    end
end