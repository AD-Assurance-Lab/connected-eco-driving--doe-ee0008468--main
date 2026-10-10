%% V2V Test File
lap1 = load('Lap1PartialData');
lap2 = load('Lap2PartialData');

%%
lap1LL = [lap1.EgoDataByDist.latitude; lap1.EgoDataByDist.longitude];
lap2LL = [lap2.EgoDataByDist.latitude; lap2.EgoDataByDist.longitude];
% make lap1 and lap 2 the same lengths

lap1LL = lap1LL(:,1:length(lap2LL));

% finding corresponding positions
IDX = knnsearch(lap1LL', lap2LL');


mu = zeros(1,length(lap2LL));
for i = 1:(length(lap2LL))
    % lap1 = IDX(i) because IDX corresponds to index of lap 1 that matches
    % lap2.. lap2 = i because that is the lap2 value that corresponds to
    % the displayed lap1 IDX value
    mu(i) = mean([lap1.EgoDataByDist(IDX(i)).V2I.speed; lap2.EgoDataByDist(i).V2I.speed]);
    sigma(i) = std([lap1.EgoDataByDist(IDX(i)).V2I.speed; lap2.EgoDataByDist(i).V2I.speed]);
end

    