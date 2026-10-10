function [dataOut]=ConcatenateTSPData(dataIn)
dataOut=struct('frame',[]);
%% Time Vector Generation
timeCells=dataIn.text(8:end,1)';
time=zeros(1,numel(timeCells));
for i=1:1:numel(timeCells)
    c=timeCells(i);
    s=c{:};
    H=str2double(s(11));
    M=str2double(s(13:14));
    S=str2double(s(16:17));
    time(i)=(H+12)*60*60+M*60+S;
end
dataOut.frame(1).time=time(1);
dataOut.frame(1).signal(1)=struct('phase',dataIn.text(8,3),'detail',dataIn.text(8,4));
j=1; k=1;
for i=2:1:numel(time)
    if time(i)==time(i-1)
        k=k+1;
        dataOut.frame(j).signal(k)=struct('phase',dataIn.text(7+i,3),'detail',dataIn.text(7+i,4));
    else
        j=j+1; k=1;
        dataOut.frame(j).time=time(i);
        dataOut.frame(j).signal(k)=struct('phase',dataIn.text(7+i,3),'detail',dataIn.text(7+i,4));
    end
end
end