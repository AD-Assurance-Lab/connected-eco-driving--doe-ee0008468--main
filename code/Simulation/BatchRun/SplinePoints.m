function [xq,vq,lamdaI,lamdaC,sequences]=SplinePoints(x,v,precision)
            %Initialization
            xv=[x;v];
            curve=cscvn(xv);
            sequences=struct('sequence',[]);
            xq=[]; vq=[]; k=0;
            for i=1:1:numel(curve.breaks)-1
                start=curve.breaks(i);
                finish=curve.breaks(i+1);
                dist=[start:precision:finish];
                val=fnval(curve,dist);
                sequenceStart=k+1;
                for j=1:1:numel(dist)
                    k=k+1;
                    xq(k)=val(1,j);
                    vq(k)=val(2,j);
                end
                sequenceEnd=k;
                sequences(i).sequence=[sequenceStart:1:sequenceEnd];
            end
            lamdaI=zeros(1,numel(xq));
            for i=2:1:numel(xq)-1
                [~,segln]=arclength([xq(i-1) xq(i) xq(i+1)],[vq(i-1) vq(i) vq(i+1)]);
                lamdaI(i)=segln(end);
            end
            lamdaI(1)=lamdaI(2);
            lamdaI(end)=lamdaI(end-1);
            lamdaC=zeros(1,numel(xq));
            for i=2:1:numel(xq)
                lamdaC(i)=lamdaC(i-1)+lamdaI(i);
            end
end