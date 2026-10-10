function [dataOut]=PullFromSingleFreematicsFile(inFile)
%% Pull Data from Single Freematics File
[~,~,raw]=xlsread(inFile);
dataOut=struct('latitude',[],'longitude',[]);
writeData=0;
for i=1:1:numel(raw(:,1))
    if raw{i,2}==10
        writeData=1;
    end
    if  writeData==1
        if raw{i,2}==10
            timeChar=num2str(raw{i,3});
            h=str2double(timeChar(1:2));
            m=str2double(timeChar(3:4));
            s=str2double(timeChar(5:6));
            f=str2double(timeChar(7:8));
            time=h*3600+m*60+s+f/100;
%             disp([h m s f time])
%             dataOut.time(j)=time;
        elseif strcmpi(raw{i,2},'A')
            dataOut.latitude=[dataOut.latitude,[raw{i,3};time]];
        elseif strcmpi(raw{i,2},'B')
            dataOut.longitude=[dataOut.longitude,[raw{i,3};time]];
        end
    end
end
