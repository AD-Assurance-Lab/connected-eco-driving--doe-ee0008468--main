classdef V2ISegment<handle
    %defines a V2I monitored segment by the GNSS points of its termini and
    %relays the current segment speed
    properties
        LAT %GNSS latitude pairs
        LON %GNSS longitude pairs
        MSS %Vector of monitored segment speeds by time
        CSS %Current segment speed
    end
    methods
        function obj=V2ISegment(LAT,LON,MSS)
            if nargin>0
                obj.LAT=LAT;
                obj.LON=LON;
                obj.MSS=MSS;
            end
            obj.Populate();
        end
        function obj=Populate(obj)
            %placeholder for function which fills in non-input properties
        end
        function obj=RollingAverage(obj,numPoints)
            %placeholder for function which generates a <numPoints> rolling
            %average of MSS data
        end
        function obj=Step(obj,ego)
            %placeholder for function which takes location and time from 
            %ego vehicle and updates object data
        end
    end
end