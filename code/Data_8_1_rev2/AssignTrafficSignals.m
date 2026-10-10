function [EgoDataByDist,j]=AssignTrafficSignals(EgoDataByDist,TrafficSignalIndices,InterpolatedTSP,i,j,numLights)
%% Description
% Blah blah blah .....
% 2. Traffic lights (TSP):
% 	indices onf next m traffic lights
% 	distances to next m traffic lights along ego path
% 	phases of the signals for each of the m lights
%% Assigning the indices
if i==TrafficSignalIndices(j) %incrementing the traffic signal index for 
    %the immediate signal based on the current index of the ego path
    j=j+1;
end
if j>numel(TrafficSignalIndices)
    j=1;
end
% Adding the next indices
signalsToRecord=[j:1:j+numLights]; %indices of signals to record
for k=1:1:numel(signalsToRecord)
    if signalsToRecord(k)>numel(TrafficSignalIndices)
        signalsToRecord(k)=signalsToRecord(k)-numel(TrafficSignalIndices);
    end
    EgoDataByDist(i).TSP.indices(k)=signalsToRecord(k); %added the index
    EgoDataByDist(i).TSP.distances(k)=EgoDataByDist(TrafficSignalIndices(signalsToRecord(k))).distance-EgoDataByDist(i).distance; %add the distance
    EgoDataByDist(i).TSP.phases(k)=InterpolatedTSP(signalsToRecord(k),i); %add the phase
end
