close all
fov=[12 18 20];
range=[160 100 60];
x1=[0 range(1)*cosd([-fov(1)/2:.1:fov(1)/2])];
y1=[0 range(1)*sind([-fov(1)/2:.1:fov(1)/2])];
x2=[0 range(2)*cosd([-fov(2)/2:.1:fov(2)/2])];
y2=[0 range(2)*sind([-fov(2)/2:.1:fov(2)/2])];
x3=[0 range(3)*cosd([-fov(3)/2:.1:fov(3)/2])];
y3=[0 range(3)*sind([-fov(3)/2:.1:fov(3)/2])];
figure
hold on
pa=patch(x1,y1,'b');
pa.FaceAlpha=.2;
pa=patch(x2,y2,'r');
pa.FaceAlpha=.2;
pa=patch(x3,y3,'g');
pa.FaceAlpha=.2;
axis equal
xv=pa.XData;
yv=pa.YData;
xq=160*rand(1,100);
yq=60*rand(1,100).*randi([-1 1],1,100);
[in1,on1] = inpolygon(xq,yq,x1,y1);
[in2,on2] = inpolygon(xq,yq,x2,y2);
[in3,on3] = inpolygon(xq,yq,x3,y3);
for i=1:1:numel(in1)
%     [in1(i) in2(i) in3(i)]
    if any([in1(i) in2(i) in3(i)])
        plot(xq(i),yq(i),'ob')
    else
        plot(xq(i),yq(i),'or')
    end
end
%%
figure
vertX=[0 range(3)*cosd(-fov(3)/2) range(2)*cosd(-fov(2)/2) range(1)*cosd(-fov(1)/2) range(1)*cosd(fov(1)/2) range(2)*cosd(fov(2)/2) range(3)*cosd(fov(3)/2) 0];
vertY=[0 range(3)*sind(-fov(3)/2) range(2)*sind(-fov(2)/2) range(1)*sind(-fov(1)/2) range(1)*sind(fov(1)/2) range(2)*sind(fov(2)/2) range(3)*sind(fov(3)/2) 0];
% x1=linspace(vertX(1),vertX(4),50);
% x2=linspace(vertX(5),vertX(8),50);
% y1=interp1(vertX(1:4),vertY(1:4),x1,'linear');
% y2=interp1(vertX(5:8),vertY(5:8),x2,'linear');
% X=[x1 range(1)*cosd([-fov(1)/2:.1:fov(1)/2]) x2];
% Y=[y1 range(1)*sind([-fov(1)/2:.1:fov(1)/2]) y2];
[X,Y]=SplinePoints(vertX,vertY,.1);
pa=patch([0 range(1)*cosd([-fov(3)/2:.1:fov(3)/2]) 0],[0 range(1)*sind([-fov(3)/2:.1:fov(3)/2]) 0],'b');
pa.FaceAlpha=.2;
p=polyshape(X,Y);
pa=patch(p.Vertices(:,1),p.Vertices(:,2),'y');
pa.FaceAlpha=.2;
axis equal
%%
[PL]=RealCone([60 100 160],[20 18 12]);
figure
hold on
pa=patch(PL.Vertices(:,1),PL.Vertices(:,2),'r');
pa.FaceAlpha=.2;
% pa=patch(PS.Vertices(:,1),PS.Vertices(:,2),'b');
% pa.FaceAlpha=.2;
axis equal
%%
[PL]=RealCone([10 70],[150 10]);
figure
hold on
pa=patch(PL.Vertices(:,1),PL.Vertices(:,2),'r');
pa.FaceAlpha=.2;
% pa=patch(PS.Vertices(:,1),PS.Vertices(:,2),'b');
% pa.FaceAlpha=.2;
axis equal