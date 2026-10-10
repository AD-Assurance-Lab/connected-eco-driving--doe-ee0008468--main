function [PL]=RealCone(range,FOV)
%range in increasing order
vertX=zeros(1,2*numel(range)+2);
vertY=vertX;
for i=1:1:numel(range)
    vertX(i+1)=range(i)*cosd(-FOV(i)/2);
    vertY(i+1)=range(i)*sind(-FOV(i)/2);
end
temp=i+1;
for i=1:1:numel(range)
    vertX(i+temp)=range(end+1-i)*cosd(FOV(end+1-i)/2);
    vertY(i+temp)=range(end+1-i)*sind(FOV(end+1-i)/2);
end
x1=linspace(vertX(1),vertX(temp),50);
x2=linspace(vertX(temp+1),vertX(end),50);
y1=interp1(vertX(1:temp),vertY(1:temp),x1,'linear');
y2=interp1(vertX(temp+1:end),vertY(temp+1:end),x2,'linear');
X=[x1 range(end)*cosd([-FOV(end)/2:.1:FOV(end)/2]) x2];
Y=[y1 range(end)*sind([-FOV(end)/2:.1:FOV(end)/2]) y2];
PL=polyshape(X,Y);
end