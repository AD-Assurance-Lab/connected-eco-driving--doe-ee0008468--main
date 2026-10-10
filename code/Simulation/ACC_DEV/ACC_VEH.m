classdef ACC_VEH<handle
    %defines a vehicle with simple linear dynamics
    properties
        vehicle
        mass
        FX_Acc
        FX_Dec
        P
        D
        data
        timeStep
        ACC_Engaged
        unengagedSpeeds %[target upperbound] if ACC unengaged
        %vehicle will attempt to maintain target, vehicle will disengage
        %ACC if required speed is greater than upper bound
        targetAquired
        followTime
        engageThreshhold %(time-followTime) at which ACC will engage (positive) 
        KP
        KI
        KD
        err
    end
    methods
        function obj=ACC_VEH(vehicle,mass,FX_Acc,FX_Dec,KP,KI,KD,timeStep,followTime,engageThreshhold,unengagedSpeeds)
            if nargin>0
                obj.vehicle=vehicle;
                obj.mass=mass;
                obj.FX_Acc=FX_Acc;
                obj.FX_Dec=FX_Dec;
                obj.KP=KP;
                obj.KI=KI;
                obj.KD=KD;
                obj.timeStep=timeStep;
                obj.followTime=followTime;
                obj.engageThreshhold=engageThreshhold;
                obj.unengagedSpeeds=unengagedSpeeds;
                obj.Initialize();
            end
        end
        function obj=Initialize(obj)
            obj.ACC_Engaged=0;
            obj.targetAquired=0;
            obj.data=struct('time',[],'velocity',[],'position',[],'targetVehicleVelocity',[], ...
                'targetVehiclePosition',[],'targetVehicleID',[],'targetSpeed',[], ...
                'ACC_Engaged',[],'targetAquired',[],'DX',[],'targetDX',[]);
            obj.err=[0 0 0];
        end
        function targetVehicle=AquireTargetVehicle(obj,scenario)
            obj.targetAquired=1;
            targetVehicle=scenario.Actors(2);
        end
        function targetSpeed=ReturnTargetSpeed(obj,targetVehicle)
            followDist=obj.ReturnFollowDistance(targetVehicle.Velocity(1));
            dx=targetVehicle.Position(1)-obj.vehicle.Position(1);
            if dx>followDist+obj.engageThreshhold
                obj.err(1)=0;
                obj.err(2)=0;
                obj.err(3)=0;
                targetSpeed=obj.unengagedSpeeds(1);
                obj.ACC_Engaged=0;
            else
                err_old=obj.err;
                obj.err(1)=dx-followDist;
                obj.err(2)=err_old(1)+obj.err(1)*obj.timeStep;
                obj.err(3)=(obj.err(1)-err_old(1))/obj.timeStep;
%                 disp(obj.err)
                targetSpeed=obj.vehicle.Velocity(1)+obj.KP*obj.err(1)+obj.KI*obj.err(2)+obj.KD*obj.err(3);
                obj.ACC_Engaged=1;
            end    
        end
        function followDist=ReturnFollowDistance(obj,velocity)
            followDist=velocity*obj.followTime;
        end
        function obj=Dynamics(obj,targetSpeed)
            accPrime=(targetSpeed-obj.vehicle.Velocity(1))/obj.timeStep;
            FXPrime=obj.mass*accPrime;
            if FXPrime>obj.FX_Acc
                FXPrime=obj.FX_Acc;
            elseif FXPrime<obj.FX_Dec
                FXPrime=obj.FX_Dec;
            end
            vel=obj.vehicle.Velocity(1)+FXPrime/obj.mass*obj.timeStep;
            if vel>obj.unengagedSpeeds(2)
                vel=obj.unengagedSpeeds(2);
            end
            obj.vehicle.Velocity(1)=vel;
            obj.vehicle.Position(1)=obj.vehicle.Position(1)+obj.vehicle.Velocity(1)*obj.timeStep;
        end
        function obj=Step(obj,scenario,time,index)
            targetVehicle=obj.AquireTargetVehicle(scenario);
            targetSpeed=obj.ReturnTargetSpeed(targetVehicle);
            obj.Dynamics(targetSpeed);
            obj.data.velocity(index,:)=obj.vehicle.Velocity;
            obj.data.position(index,:)=obj.vehicle.Position;
            obj.data.targetVehicleVelocity(index,:)=targetVehicle.Velocity;
            obj.data.targetVehiclePosition(index,:)=targetVehicle.Position;
            obj.data.targetSpeed(index)=targetSpeed;
            obj.data.time(index)=time;
            obj.data.targetVehicleID(index)=targetVehicle.ActorID;
            obj.data.ACC_Engaged(index)=obj.ACC_Engaged;
            obj.data.targetAquired(index)=obj.targetAquired;
            obj.data.DX(index)=sqrt((obj.vehicle.Position(1)-targetVehicle.Position(1))^2+...
                (obj.vehicle.Position(2)-targetVehicle.Position(2))^2);
            obj.data.targetDX(index)=obj.ReturnFollowDistance(targetVehicle.Velocity(1));
        end
    end
end  