function [EgoDataByDist,j]=AssignV2V(EgoDataByDist,i,j,prevLap)
%% Description: 
% 4. Historical data (V2V):
% 	Mu and Sigma for Speeds of "historical traces" at ego latlon
% Compare ego lat lon values during each lap

%%
lap1LL = [prevLap.EgoDataByDist.latitude; prevLap.EgoDataByDist.longitude];
lap2LL = [EgoDataByDist.latitude; EgoDataByDist.longitude];
% make lap1 and lap 2 the same lengths

lap1LL = lap1LL(:,1:length(lap2LL));

% finding corresponding positions
for k=1:1:numel(lap1LL)
    boundingBox=[lap1LL(k,1)-.001,lap1LL(k,2)-.001;... %South West
        lap1LL(k,1)-.001,lap1LL(k,2)+.001;... %South Ease
        lap1LL(k,1)+.001,lap1LL(k,2)-.001;... %North West
        lap1LL(k,1)+.001,lap1LL(k,2)+.001]; %North East
    in=inpolygon(lap1LL(:,1),lap1LL(:,2),boundingBox(:,1),boundingBox(:,1));

IDX = knnsearch(lap1LL(k)', lap2LL(in)');

mu = zeros(1,length(lap2LL));
sigma = zeros(1,length(lap2LL));
% 
% for i = 1:(length(lap2LL))
    % lap1 = IDX(i) because IDX corresponds to index of lap 1 that matches
    % lap2.. lap2 = i because that is the lap2 value that corresponds to
    % the displayed lap1 IDX value
    EgoDataByDist(i).V2V.mu = mean([prevLap.EgoDataByDist(IDX(i)).V2I.speed; EgoDataByDist(i).V2I.speed]);
    EgoDataByDist(i).V2V.sigma = std([prevLap.EgoDataByDist(IDX(i)).V2I.speed; EgoDataByDist(i).V2I.speed]);
% end
end

end


