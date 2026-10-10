classdef SensorFusion<handle
    % This constructor creates and handles a SensorFusion object
    properties
        FilterInitializationFcn % A handle to a function that initializes a tracking filter based on a detection
        AssignmentThreshold % The threshold that controls the assignment of detections to tracks
        ConfirmationParameters % Specify M and N for the M-out-of-N confirmation logic
        NumCoastingUpdates % Number of steps a confirmed track is coasted (predicted without a detection) before deletion
        MaxNumTracks % Maximum number of tracks which the fusion can produce
        TWODKF % boolean: 1 - 2D Kalman Filter, 0 - 3D Kalman Filter
        Sensors % Heterogenous array of sensors in simulation
        Tracker % Stores the multiObjectTracker object
        BEP % Stores a birds eye plot for use with various track plots
        Plots % Stores various track plots
        Data
        Objects
    end
    methods
        function obj=SensorFusion(Sensors,FilterInitializationFcn,AssignmentThreshold,ConfirmationParameters,NumCoastingUpdates,MaxNumTracks,TWODKF)
            if nargin>0
                obj.Sensors=Sensors;
                obj.FilterInitializationFcn=FilterInitializationFcn;
                obj.AssignmentThreshold=AssignmentThreshold;
                obj.ConfirmationParameters=ConfirmationParameters;
                obj.NumCoastingUpdates=NumCoastingUpdates;
                obj.MaxNumTracks=MaxNumTracks;
                obj.TWODKF=TWODKF;
                obj.Initialize();
            end
        end
        function obj=Step(obj,EgoVehicle,time,index,GraphsBool)
%             fprintf('sf: %f\n',time')
            %Importing lanes and objects information in 3D for sensors
            LookAheadDistance = 0:0.5:200;
            LB=laneBoundaries(EgoVehicle,'XDistance',LookAheadDistance,'LocationType','center', 'AllBoundaries', true);
            TP=targetPoses(EgoVehicle);
            [objposition,objyaw,objlength,objwidth,objriginOffset,color] = targetOutlines(EgoVehicle);
            T.objposition=objposition;
            T.objyaw=objyaw;
            T.objlength=objlength;
            T.objwidth=objwidth;
            T.objriginOffset=objriginOffset;
            T.color=color;
            T.TP=TP;
            assignin('base','T',T);
            %Initializing loop variables
            LaneDetections=[]; LanesValid=[];
            TempObjects=[]; ObjectsValid=[];
            VisualPositions=[];
            RadarPositions=[];
            LiDARPositions=[];
            nvdets=0;
            nrdets=0;
            nldets=0;
            %loop on all sensors
            for i=1:1:numel(obj.Sensors)
                %sorting by type
                switch obj.Sensors{i}.Type
                    case 1 %visual
                        [ObjDets,ObjValid,LBDets,LBValid,Positions,newDetections]=obj.Sensors{i}.Detections(TP,LB,time,index,obj.TWODKF); %Calling Sensor
                        LaneDetections=[LaneDetections;LBDets]; LanesValid=[LanesValid LBValid]; %array of lanes seen and validity
%                         Objects=[Objects;ObjDets]; 
                        ObjectsValid=[ObjectsValid ObjValid]; %array of objects seen and validity
                        if newDetections==1
                            obj.Objects(i).ObjDets=ObjDets;
                        end
                        TempObjects=[TempObjects;obj.Objects(i).ObjDets];
                        VisualPositions=[VisualPositions;Positions]; %array of 2D positions of objects
                        nvdets=numel(VisualPositions);
                    case 2 %radar
                        [ObjDets,ObjValid,Positions,newDetections]=obj.Sensors{i}.Detections(TP,time,index,obj.TWODKF); %Calling Sensor
%                         Objects=[Objects;ObjDets]; ObjectsValid=[ObjectsValid ObjValid]; %array of objects seen and validity
                        ObjectsValid=[ObjectsValid ObjValid]; %array of objects seen and validity
                        if newDetections==1
%                             disp(i)
                            obj.Objects(i).ObjDets=ObjDets;
                        end
                        TempObjects=[TempObjects;obj.Objects(i).ObjDets];
                        RadarPositions=[RadarPositions;Positions]; %array of 2D positions of objects
                        nrdets=numel(RadarPositions);
                    case 3 %LiDAR
                        [ObjDets,ObjValid,Positions,newDetections]=obj.Sensors{i}.Detections(TP,time,index,obj.TWODKF); %Calling Sensor
%                         Objects=[Objects;ObjDets]; ObjectsValid=[ObjectsValid ObjValid]; %array of objects seen and validity
                        ObjectsValid=[ObjectsValid ObjValid]; %array of objects seen and validity
                        if newDetections==1
                            obj.Objects(i).ObjDets=ObjDets;
                        end
                        TempObjects=[TempObjects;obj.Objects(i).ObjDets];
                        LiDARPositions=[LiDARPositions;Positions]; %array of 2D positions of objects
                        nldets=numel(LiDARPositions);
                end
            end
            for i=1:1:numel(TempObjects)
                TempObjects{i}.Time=time;
            end
            assignin('base','Objects',TempObjects)
            assignin('base','RadarPositions',RadarPositions)
            assignin('base','VisualPositions',VisualPositions)
            assignin('base','LiDARPositions',LiDARPositions)
            ConfirmedTracks=[]; TentativeTracks=[];
            if any(ObjectsValid)
                [ConfirmedTracks,TentativeTracks]=obj.Tracker(TempObjects,time); %Calling the Tracker
                PositionSelector = [1 0 0 0; 0 0 1 0]; %for state vector [dx;vx;dy;vy] produces positions
                VelocitySelector = [0 1 0 0; 0 0 0 1]; %for state vector [dx;vx;dy;vy] produces velocities
                TrackPositions = getTrackPositions(ConfirmedTracks,PositionSelector);
                TrackVelocities = getTrackVelocities(ConfirmedTracks,VelocitySelector);
                for i=1:1:numel(ConfirmedTracks)
                    obj.Data.(sprintf('Track_%i_%s',i,'dx'))(index)=ConfirmedTracks(i).State(1);
                    obj.Data.(sprintf('Track_%i_%s',i,'dy'))(index)=ConfirmedTracks(i).State(3);
                    obj.Data.(sprintf('Track_%i_%s',i,'vx'))(index)=ConfirmedTracks(i).State(2);
                    obj.Data.(sprintf('Track_%i_%s',i,'vy'))(index)=ConfirmedTracks(i).State(4);
                    obj.Data.(sprintf('Track_%i_%s',i,'age'))(index)=ConfirmedTracks(i).Age;
                end
            end
            if numel(ConfirmedTracks)>0
                fprintf('%i Confirmed Tracks and %i Tentative Tracks ...\n',numel(ConfirmedTracks),numel(TentativeTracks))
            end
%             if numel(ConfirmedTracks)>0
%                 assignin('base','ConfirmedTracks',ConfirmedTracks)
%             end
%             if numel(TentativeTracks)>0
%                 assignin('base','TentativeTracks',TentativeTracks)
%             end
            if GraphsBool==1
                [LMV,LMF]=laneMarkingVertices(EgoVehicle);
                plotLaneMarking(obj.Plots.LM,LMV,LMF);
                [objposition,objyaw,objlength,objwidth,objriginOffset,color] = targetOutlines(EgoVehicle);
                plotOutline(obj.Plots.OL,objposition,objyaw,objlength,objwidth,'OriginOffset',objriginOffset,'Color', color)
                if nvdets>=1
                    % disp('a')
                    % disp(VisualPositions)
                    plotDetection(obj.Plots.VP,VisualPositions);
                end
                if nrdets>=1
                    % disp('b')
%                     disp(RadarPositions)
                    plotDetection(obj.Plots.RP,RadarPositions);
                end
                if nldets>=1
                    % disp('c')
                    % disp(LiDARPositions)
                    plotDetection(obj.Plots.LP,LiDARPositions);
                end
                if numel(ConfirmedTracks)>=1
                    plotTrack(obj.Plots.TP,TrackPositions,TrackVelocities);
                end
                if numel(LaneDetections)>=1 && any(LanesValid)
                    plotLaneBoundary(obj.Plots.LB,vertcat(LaneDetections.LaneBoundaries))
                end  
            end
        end
        function BEP=InitializePlots(obj,BirdsEyePlot)
            if nargin<2
                BEP=birdsEyePlot();
                for i=1:1:numel(obj.Sensors)
                    BEP=obj.Sensors{i}.PlotFOV(BEP);
                end
            else
                BEP=BirdsEyePlot;
                for i=1:1:numel(obj.Sensors)
                    BEP=obj.Sensors{i}.PlotFOV(BEP);
                end
            end
            obj.Plots.LM = laneMarkingPlotter(BEP,'DisplayName','Lane Markings');
            obj.Plots.OL = outlinePlotter(BEP);
            obj.Plots.LB = laneBoundaryPlotter(BEP,'DisplayName', 'Lane Boundary Detections','Color','y');
            obj.Plots.VP = detectionPlotter(BEP,'DisplayName','Vision','MarkerEdgeColor','b');
            obj.Plots.RP = detectionPlotter(BEP,'DisplayName','Radar','MarkerEdgeColor','r','Marker','x');
            obj.Plots.LP = detectionPlotter(BEP,'DisplayName','Lidar','MarkerEdgeColor','g','Marker','d');
            obj.Plots.TP = trackPlotter(BEP,'DisplayName','Track','HistoryDepth',10,'MarkerEdgeColor','r','Marker','s');
        end
        function obj=Initialize(obj)
            obj.Tracker = multiObjectTracker();
            obj.Tracker.FilterInitializationFcn=obj.FilterInitializationFcn;   %- A handle to a function that initializes
        %                             %    a tracking filter based on a detection
            obj.Tracker.AssignmentThreshold=obj.AssignmentThreshold;       %- The threshold that controls the
        %                             %    assignment of detections to tracks
            obj.Tracker.ConfirmationParameters=obj.ConfirmationParameters;    %- Specify M and N for the M-out-of-N
        %                             %    confirmation logic
            obj.Tracker.NumCoastingUpdates=obj.NumCoastingUpdates;        %- Number of steps a confirmed track is
        %                             %    coasted (predicted without a detection)
        %                             %    before deletion
            obj.Tracker.MaxNumTracks=obj.MaxNumTracks;              %- Define the maximum number of tracks
        %     obj.Tracker.MaxNumSensors             %- Define the maximum number of sensors
        %     obj.Tracker.HasCostMatrixInput        %- Provide cost matrix as an input to 
        %                               %  updateTracks
        %     obj.Tracker.NumTracks                 %- Total number of tracks, (Read-only)
        %     obj.Tracker.NumConfirmedTracks        %- Number of confirmed tracks, (Read-only)
            NMessages=obj.Tracker.MaxNumTracks;
            SignalNames={'dx','dy','vx','vy','age'};
            for i=1:1:NMessages
                for j=1:1:numel(SignalNames)
                    c=SignalNames(j); s=c{:};
                    obj.Data.(sprintf('Track_%i_%s',i,s))=[];
                end
            end
            obj.Objects=struct('ObjDets',{});
            for i=1:1:numel(obj.Sensors)
                obj.Objects(i).ObjDets={};
            end  
        end
    end         
end