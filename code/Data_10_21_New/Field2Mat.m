function [vec]=Field2Mat(struct,fieldName)
vec=zeros(numel(struct),numel(struct(1).(fieldName)));
for i=1:1:numel(vec(:,1))
    vec(i,:)=struct(i).(fieldName);
end
end