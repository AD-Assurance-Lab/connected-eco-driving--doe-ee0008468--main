function [EgoDataByDist,k]=AssignTrafficSignals(EgoDataByDist,TrafficSignalIndices,InterpolatedTSP,j,k,numLights)
%% Description
% Blah blah blah .....
% 2. Traffic lights (SPaT):
% 	indices onf next m traffic lights
% 	distances to next m traffic lights along ego path
% 	phases of the signals for each of the m lights
%% Assigning the indices
% disp(k)
if j==TrafficSignalIndices(k) %incrementing the traffic signal index for 
%     disp('yes')
    %the immediate signal based on the current index of the ego path
    k=k+1;
end
if k>numel(TrafficSignalIndices)
%     disp('yes')
    k=1;
end
% disp(k)
% Adding the next indices
signalsToRecord=[k:1:k+numLights]; %indices of signals to record
for l=1:1:numel(signalsToRecord)
    if signalsToRecord(l)>numel(TrafficSignalIndices)
        signalsToRecord(l)=signalsToRecord(l)-numel(TrafficSignalIndices);
    end
    EgoDataByDist.SPaT(j).indices(l)=signalsToRecord(l); %added the index
    trafficLightDist=EgoDataByDist.Distance(TrafficSignalIndices(signalsToRecord(l)));
    vehDist=EgoDataByDist.Distance(j);
    if trafficLightDist>=vehDist
        EgoDataByDist.SPaT(j).distances(l)=trafficLightDist-vehDist; %add the distance
    else
        EgoDataByDist.SPaT(j).distances(l)=EgoDataByDist.Distance(end)-vehDist+trafficLightDist;
    end
    EgoDataByDist.SPaT(j).phases(l)=InterpolatedTSP(signalsToRecord(l),j); %add the phase
end
% disp(k)
