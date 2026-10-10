function [dataOut]=PullFromSingleFreematicsFileAdvanced(inFile)
%% Pull Data from Single Freematics File
[~,~,raw]=xlsread(inFile);
dataOut=struct('latitude',[],'longitude',[],'altitude',[],'GPSSpeed',[],'engineLoad',[],'engineRPM',[],'throttlePosition',[],'OBDSpeed',[]);
writeData=0;
for i=1:1:numel(raw(:,1))
    if raw{i,2}==10
        writeData=1;
    end
    if  writeData==1
        if raw{i,2}==10 %time
            timeChar=num2str(raw{i,3});
            h=str2double(timeChar(1:2));
            m=str2double(timeChar(3:4));
            s=str2double(timeChar(5:6));
            f=str2double(timeChar(7:8));
            time=h*3600+m*60+s+f/100;
%             disp([h m s f time])
        elseif strcmpi(raw{i,2},'A') %latitude
            dataOut.latitude=[dataOut.latitude,[raw{i,3};time]];
        elseif strcmpi(raw{i,2},'B') %longitude
            dataOut.longitude=[dataOut.longitude,[raw{i,3};time]];
        elseif strcmpi(raw{i,2},'C') %altitude
            dataOut.altitude=[dataOut.altitude,[raw{i,3};time]];
        elseif strcmpi(raw{i,2},'D') %GPS Speed
            dataOut.GPSSpeed=[dataOut.GPSSpeed,[raw{i,3};time]];
        elseif raw{i,2}==104 %engine Load
            dataOut.engineLoad=[dataOut.engineLoad,[raw{i,3};time]];
        elseif strcmpi(raw{i,2},'10C') %engine RPM
            dataOut.engineRPM=[dataOut.engineRPM,[raw{i,3};time]];
        elseif raw{i,2}==111 %Throttle Position
            dataOut.throttlePosition=[dataOut.throttlePosition,[raw{i,3};time]];
        elseif strcmpi(raw{i,2},'10D') %OBD Speed
            dataOut.OBDSpeed=[dataOut.OBDSpeed,[raw{i,3};time]];
        end
    end
end
