%% Designed Experiment on CAVS Configureations

%% DOE
ff=fullfact([3 3]);
%%
scenario=drivingScenario;
RoadCenters=[0 0 0;200 0 0];
%real valued n*3 matrix for (x,y,z) pos of road centerpoint
RoadWidth=[]; %positive, real scalar
BankingAngle=[0 0]; %real n*1 vector; in degrees
NumberOfLanes=[2]; %positive integer
Width=[6]; %m*1 vector of positive real values
Marking=laneMarking('Solid'); %'Unmarked','Solid','Dashed','DoubleSolid','DoubleDashed','SolidDashed','DashedSolid'
LaneSpec=lanespec(NumberOfLanes,'Width',Width,'Marking',Marking);
%road(varargin) can be called using a single road width or 
%with laneSpec
% road(sc,roadcenters,roadwidth,bankingangle)
road(drivingScenario,RoadCenters,BankingAngle,'Lanes',LaneSpec)
ClassID=1; %user parameter - recommend 1 for Ego Vehicle
Position=[0 -3 0]; %starting position of the vehicle
EgoVehicle=vehicle(drivingScenario,'ClassID',ClassID,'Position',Position);
%%
radar={}; vision={};
for i=1:1:numel(ff(:,1))
    clear radar vision
    switch ff(i,1)
        case 1
            radar{1}=Radar('Front1',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang 0 .2],[0 0 0],[18 32],100);
            radar{2}=Radar('Front2',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang 0 .2],[0 0 0],[20 32],60);
            radar{3}=Radar('Rear',[-EgoVehicle.RearOverhang 0 .2],[0 0 180],[56 32],80);
            radar{4}=Radar('LeftCenter',[EgoVehicle.Wheelbase/2 EgoVehicle.Width/2 .5],[0 0 90],[150 32],40);
            radar{5}=Radar('RightCenter',[EgoVehicle.Wheelbase/2 -EgoVehicle.Width/2 .5],[0 0 -90],[150 32],40);
        case 2
            radar{1}=Radar('Front1',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang 0 .2],[0 0 0],[18 32],100);
            radar{2}=Radar('Front2',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang 0 .2],[0 0 0],[20 32],60);
            radar{3}=Radar('Rear',[-EgoVehicle.RearOverhang 0 .2],[0 0 180],[56 32],80);
            radar{4}=Radar('FrontLeft',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang EgoVehicle.Width/2 .2],[0 0 45],[150 32],40);
            radar{5}=Radar('FrontRight',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang -EgoVehicle.Width/2 .2],[0 0 -45],[150 32],40);
        case 3
            radar{1}=Radar('Front1',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang 0 .2],[0 0 0],[18 32],100);
            radar{2}=Radar('Front2',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang 0 .2],[0 0 0],[20 32],60);
            radar{3}=Radar('Rear',[-EgoVehicle.RearOverhang 0 .2],[0 0 180],[56 32],80);
            radar{4}=Radar('FrontLeft',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang EgoVehicle.Width/2 .2],[0 0 45],[150 32],40);
            radar{5}=Radar('FrontRight',[EgoVehicle.Wheelbase + EgoVehicle.FrontOverhang -EgoVehicle.Width/2 .2],[0 0 -45],[150 32],40);
            radar{6}=Radar('RearLeft',[-EgoVehicle.FrontOverhang EgoVehicle.Width/2 .2],[0 0 135],[150 32],40);
            radar{7}=Radar('RearRight',[-EgoVehicle.FrontOverhang -EgoVehicle.Width/2 .2],[0 0 -135],[150 32],40);
    end
    switch ff(i,2)
        case 1
            vision{1}=Mobileye6('camera',[0.75*EgoVehicle.Wheelbase 0 1.1],[0 0 0]);
        case 2
            vision{1}=Mobileye6('camera',[0.75*EgoVehicle.Wheelbase EgoVehicle.Width/4 1.1],[0 0 0]);
        case 3
            vision{1}=Mobileye6('camera',[0.75*EgoVehicle.Wheelbase -EgoVehicle.Width/4 1.1],[0 0 0]);
    end
%     bep = birdsEyePlot('XLimits',[-10 20],'YLimits',[-10 10]);
    CoveragePlot(drivingScenario,radar,vision)
%         return
end