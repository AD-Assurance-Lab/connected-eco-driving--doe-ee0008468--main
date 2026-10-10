function [dataOut]=ConcatenateTSPDataCombined(File,dataStart)
[~,~,raw]=xlsread(File); %reading the excel file in as cells
raw=raw(dataStart:end,:); %cutting out the headers and last line (comes in as NaNs)
for i=1:1:numel(raw(:,1)) %changing the signal names to acceptable MATLAB variable names
    str=raw{i,2};
    str=strrep(str,' ','_');
    str=strrep(str,'(','');
    str=strrep(str,')','');
    str=strrep(str,'&','');
    str=strrep(str,'__','_');
    raw(i,2)={str};
end
dataOut=struct('name',[],'data',[],'dataTemp',[],'indices',[]);
%data structure with some temporary fields

signals=unique(raw(:,2)); %finding the unique signal names and assigning 
%them to the names field in the output data
for i=1:1:numel(signals)
    dataOut(i).name=signals{i};
end
%finding the indices for which the data corresponds to each signal
for i=1:1:numel(raw(:,1))
    for j=1:1:numel(dataOut)
        if strcmpi(raw{i,2},dataOut(j).name)
            dataOut(j).indices=[dataOut(j).indices i];
        end
    end
end
%calling the data processing function for esch singal's data
for i=1:1:numel(dataOut)
    dataOut(i).dataTemp=raw(dataOut(i).indices,:);
    dataOut(i).data.frame=GenerateFrames(dataOut(i).dataTemp);
%     break
end
%removing temporary fields
dataOut=rmfield(dataOut,'dataTemp');
dataOut=rmfield(dataOut,'indices');
end
function frame=GenerateFrames(dataTemp)
%% Time Vector Generation
for i=1:1:numel(dataTemp(:,1))
    inString=dataTemp{i,1}; %parsing the time sting and calculating seconds since midnight
    c={[regexp(inString,'[0-9][:][0-9][0-9][:][0-9][0-9]','match') regexp(inString,'[0-9][0-9][:][0-9][0-9][:][0-9][0-9]','match')]};
    s=c{:}{:};
    if numel(s)==7
        H=str2double(s(1));
        M=str2double(s(3:4));
        S=str2double(s(6:7));
        time(i)=(H+12)*3600+M*60+S;
    else
        H=str2double(s(1:2));
        M=str2double(s(4:5));
        S=str2double(s(7:8));
        time(i)=H*3600+M*60+S;
    end
end
%parsing data by frame - multiple signals can occurr ata sinlge time stamp
%and these willbe combined into a single frame
frame(1).time=time(1);
frame(1).signal(1)=struct('phase',dataTemp{i,3},'detail',dataTemp{i,4});
j=1; k=1;
for i=2:1:numel(time)
    if time(i)==time(i-1)
        k=k+1;
        frame(j).signal(k)=struct('phase',dataTemp{i,3},'detail',dataTemp{i,4});
    else
        j=j+1; k=1;
        frame(j).time=time(i);
        frame(j).signal(k)=struct('phase',dataTemp{i,3},'detail',dataTemp{i,4});
    end
end
end