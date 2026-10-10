%% POC for generating a BEP using custom constructors
clc; close all;
%Generating the sensors
me=Mobileye6('m',[2 .25 1],[0 0 0],1);
mrrf=Bosch_MRR_Front('m',[2.5 0 .4],[0 0 0],2);
mrrcl=Bosch_MRR_Corner('m',[1 1 .4],[0 0 90],3);
mrrcr=Bosch_MRR_Corner('m',[1 -1 .4],[0 0 -90],4);
mrrr=Bosch_MRR_Rear('m',[-.5 0 .4],[0 0 180],5);
vlp=Velodyne_VLP16('nnn',[1 0 1.5],[0 0 0],6);
%BEP
BEP=me.PlotFOV();
BEP=mrrf.PlotFOV(BEP);
BEP=mrrcl.PlotFOV(BEP);
BEP=mrrcr.PlotFOV(BEP);
BEP=mrrr.PlotFOV(BEP);
BEP=vlp.PlotFOV(BEP);