classdef RoadSegment<handle
    %Defines a road segment by which GNSS positions it contains, which
    %signal terminates it, and which V2I segment speed it is subject to.
    properties
        LAT %GNSS latitude points
        LON %GNSS longitude points
        ALT %GNSS altitude points
        SIG %Singal object which terminates Segment
        SSO %Segment speed object for segment
        TSD %Total distance of segment for each GNSS location pair
        DIS %Distance traveled along segment
    end
    methods
        function obj=RoadSegment(LAT,LON,ALT,SIG,SSO)
            if nargin>0
                obj.LAT=LAT;
                obj.LON=LON;
                obj.ALT=ALT;
                obj.SIG=SIG;
                obj.SSO=SSO;
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
        function obj=CalculateDistance(obj)
            %placeholder for distance calculation
        end
    end
end
        
        
        
        