function [TimeInterpolatedData]=Data_Time_Interp_Function(RawData,Sample_Period)
%% Data Interp
%% Traffic Signal Notes
% note that the route driven was:
% 1. Mulberry/shields
% 2. Shields/Elizabeth
% 3. Shields/Prospect
% 4. Prospect/College
% 5. Prospect/Lemay
% 6. Lemay/Drake
% 7. Drake/College
% 8. College/Prospect
% 9. College/Mulberry
% Traffic signals will be interpolated in the following manner:
% Each signal will be assigned an index as above. The color of that 
% signal (Green/Yellow/Red -> 1,2,3) will be in the direction encountered 
% along the route. 
% For the intersections where right hand turns were made (5,6,7) the
% signals will be the through phase as there is no right hand turn phase.
% Left hand turns such as occurred at (1,3,9) will be treated as the left
% hand turn phase.
% The traffic signal phases in Ft. Collins are:
% Phase 1 	NB LT
% Phase 2	SB Thru
% Phase 3 	WB LT
% Phase 4	EB Thru
% Phase 5	SB LT
% Phase 6	NB Thru
% Phase 7	EB LT
% Phase 8	WB Thru
% 
% So that means that the phases which are considered "forward along the
% route" are:
% Signal                                Forward Phase
% 1. Mulberry/College - 014              Phase 1
% 2. Mulberry/Mason - 029                Phase 8
% 3. Mulberry/ S Howes - 023             Phase 8
% 4. Mulberry/S Meldrum - 131            Phase 8
% 5. Mulberry/S Sherwood - 489           Phase 8
% 6. Mulberry/S Loomis - 078             Phase 8
% 7. Mulberry/Shields - 043              Phase 3
% 8. Shields/Laurel - 044                Phase 2
% 9. Shields/Plum - 045                  Phase 2
% 10. Shields/Elizabeth - 046            Phase 2
% 11. Shields/Springfield - 486          Phase 2
% 12. Shields/Lake - 116                 Phase 2
% 13. Shields/Prospect - 047             Phase 2
% 14. Prospect/Whitcomb - 083            Phase 6
% 15. Centre/Prospect - 084              Phase 6
% 16. Prospect/Mason Corridor - 184	     Phase 4
% 17. Prospect/College - 010             Phase 7
% 28. College /Pitkin - 011              Phase 6
% 19. College /Elizabeth - 012           Phase 6
% 20. College /Laurel - 013              Phase 6
%
% When a signal is not at its designated "Forward" phase it will be
% considered to be "red" (3).
%% Initialization
dataTemp=struct('name','','data',[]);
%dataTemp will be the structure used for interpolation
%% SPaT
% In this section the SPaT RawData is generated for "forward" directiona nd
% prepared for interpolation.
Encoding=GeneratePhaseEncoding('PhaseEncoding.xlsx'); %signal index -> "forward" phase index
% Encoding
% Initializing trafficSignals structure
trafficSignals=struct('time',[],'signal',[]);
for i=1:1:numel(RawData.SPaT)
    trafficSignals(i).time=zeros(1,numel(RawData.SPaT(i).data.frame));
    trafficSignals(i).signal=3*ones(1,numel(RawData.SPaT(i).data.frame));
end
log=zeros(1,numel(trafficSignals));
for j=1:1:numel(trafficSignals) %index of signals
    for i=1:1:numel(RawData.SPaT)
        for k=1:1:numel(Encoding(:,1))
        phaseName=Encoding{k,1};
            if regexp(RawData.SPaT(j).name,phaseName)
                phase=Encoding{k,2};
                log(i)=1;
            end
        end
    end
    if log(i)==1
        for i=1:1:numel(RawData.SPaT(j).data.frame)
            %index of frames (different for each traffic light)
            phaseString=sprintf('phase #%i',phase);
            trafficSignals(j).time(i)=RawData.SPaT(j).data.frame(i).time;
            for k=1:1:numel(RawData.SPaT(j).data.frame(i).signal)
                %since the phases are initialized as "red" (3) they are only
                %changed if the assigned "forward" phase is "yellow" (2) or 
                %"green" (1)
                if strcmpi(phaseString,RawData.SPaT(j).data.frame(i).signal(k).detail)
                    if strcmpi('Phase Green',RawData.SPaT(j).data.frame(i).signal(k).phase)
                        trafficSignals(j).signal(i)=1;
                    elseif strcmpi('Phase Yellow',RawData.SPaT(j).data.frame(i).signal(k).phase)
                        trafficSignals(j).signal(i)=2;
                    end
                end
            end
        end
    end
end
% Adding SPaT RawData to interpolation structure
ind=0;
for i=1:1:numel(trafficSignals)
    if log(i)==1
        ind=ind+1;
        dataTemp(ind).name=sprintf('SPaT_%i_%s',i,strrep(RawData.SPaT(i).name,'&','_'));
        dataTemp(ind).data=[trafficSignals(i).time;trafficSignals(i).signal]';
    end
end
%% SS
j=numel(dataTemp);
for i=1:1:numel(RawData.SS)
    j=j+1;
    dataTemp(j).name=sprintf('SS_%i_%s_SegmentSpeed',i,RawData.SS(i).name);
    dataTemp(j).data=[RawData.SS(i).data.time';RawData.SS(i).data.segmentSpeed]';
    j=j+1;
    dataTemp(j).name=sprintf('SS_%i_%s_SegmentTime',i,RawData.SS(i).name);
    dataTemp(j).data=[RawData.SS(i).data.time';RawData.SS(i).data.segmentTime]';
end
%% EGO
j=numel(dataTemp);
f=fields(RawData.EGO);
for k=1:1:numel(f)
    j=j+1;
    c=f(k); s=c{:};
    dataTemp(j).name=sprintf('EGO_%s',s);
    dataTemp(j).data=[(RawData.EGO.(s)(:,1)-floor(RawData.EGO.(s)(:,1)))*24*3600 RawData.EGO.(s)(:,2)];
end
%% ADAS
j=numel(dataTemp);
f=fields(RawData.ADAS);
for i=1:1:numel(f)
    j=j+1;
    c=f(i); s=c{:};
    dataTemp(j).name=sprintf('ADAS_%i_%s',i,s);
    dataTemp(j).data=[(RawData.ADAS.(s)(:,1)-floor(RawData.ADAS.(s)(:,1)))*24*3600 RawData.ADAS.(s)(:,2)];
end
%% Time Adjustment
for i=1:1:numel(dataTemp)
    if regexp(dataTemp(i).name,'V2V')
        dataTemp(i).data(:,1)=dataTemp(i).data(:,1)+Sync_V2V;
    end
end
assignin('base','dataTemp',dataTemp);
%% Data Start and End
startTime=zeros(1,numel(dataTemp));
endTime=zeros(1,numel(dataTemp));
for i=1:1:numel(dataTemp)
%     dataTemp(i).data(:,1)=dataTemp(i).data(:,1)-dataTemp(i).data(1,1);
    startTime(i)=dataTemp(i).data(1,1);
    endTime(i)=dataTemp(i).data(end,1);
end
[~,i]=max(startTime);
firstFrame=dataTemp(i).data(1,1);
[~,i]=min(endTime);
lastFrame=dataTemp(i).data(end,1);
%% Interpolation
sampleTime=[firstFrame:Sample_Period:lastFrame];
condition=DataInterpCondition('SPaT',[1:1:4],'nearest');
TimeInterpolatedData=struct('time',[],'data',[]);
TimeInterpolatedData.data=QueryTestData(dataTemp,sampleTime,'linear',condition);
TimeInterpolatedData.time=sampleTime-sampleTime(1);
end