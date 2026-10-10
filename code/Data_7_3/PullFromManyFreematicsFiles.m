function [dataOut,tempData]=PullFromManyFreematicsFiles(Folder)
%pulls the data from many freematics files and complies into one
fileList=dir(Folder);
tempData=struct('data',[]);
j=0;
for i=1:1:numel(fileList)
    [~,~,ext]=fileparts(fileList(i).name);
    if strcmpi(ext,'.CSV')
        j=j+1;
        tempData(j).data=PullFromSingleFreematicsFileAdvanced(fileList(i).name);
    end
end
dataOut=struct('latitude',[],'longitude',[],'altitude',[],'GPSSpeed',[],'engineLoad',[],'engineRPM',[],'throttlePosition',[],'OBDSpeed',[]);
f=fields(dataOut);
for i=1:1:numel(tempData)
    for j=1:1:numel(f)
        dataOut.(f{j})=[dataOut.(f{j}) tempData(i).data.(f{j})];
    end
end
end