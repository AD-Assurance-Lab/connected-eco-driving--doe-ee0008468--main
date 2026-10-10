function [EgoDataByDist,k]=AssignTrafficSignals(EgoDataByDist,TrafficSignalIndices,InterpolatedTSP,j,k,numLights)
%% Description
% Blah blah blah .....
% 2. Traffic lights (TSP):
% 	indices onf next m traffic lights
% 	distances to next m traffic lights along ego path
% 	phases of the signals for each of the m lights
%% Assigning the indices
if j==TrafficSignalIndices(k) %incrementing the traffic signal index for 
    %the immediate signal based on the current index of the ego path
    k=k+1;
end
if k>numel(TrafficSignalIndices)
    k=1;
end
% Adding the next indices
signalsToRecord=[k:1:k+numLights]; %indices of signals to record
for k=1:1:numel(signalsToRecord)
    if signalsToRecord(k)>numel(TrafficSignalIndices)
        signalsToRecord(k)=signalsToRecord(k)-numel(TrafficSignalIndices);
    end
    EgoDataByDist.TSP(j).indices(k)=signalsToRecord(k); %added the index
    EgoDataByDist.TSP(j).distances(k)=EgoDataByDist.distance(TrafficSignalIndices(signalsToRecord(k)))-EgoDataByDist.distance(j); %add the distance
    EgoDataByDist.TSP(j).phases(k)=InterpolatedTSP(signalsToRecord(k),j); %add the phase
end
