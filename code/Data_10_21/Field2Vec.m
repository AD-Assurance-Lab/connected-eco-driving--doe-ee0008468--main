function [vec]=Field2Vec(struct,fieldName)
vec=zeros(1,numel(struct));
for i=1:1:numel(vec)
    vec(i)=struct(i).(fieldName);
end
end