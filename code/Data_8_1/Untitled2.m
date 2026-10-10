indices=[]; j=0;
GPSCell=[];
for i=1:1:numel(raw(:,1))
    name=string(raw{i,4});
    if regexp(name,'Mulberry')
        j=j+1;
        indices(j)=i;
        lineStr=raw{i,9};
        GPSCell=[GPSCell regexp(lineStr,'\s*(\-?\d+(\.\d+)?) \s*(\-?\d+(\.\d+)?)','match')];
    end
end
%%
GPS=zeros(2,numel(GPSCell));
for i=1:1:numel(GPSCell)
    num=str2num(GPSCell{i});
    GPS(1,i)=num(1);
    GPS(2,i)=num(2);
end
figure
plot(GPS(1,:),GPS(2,:),'o')
axis equal