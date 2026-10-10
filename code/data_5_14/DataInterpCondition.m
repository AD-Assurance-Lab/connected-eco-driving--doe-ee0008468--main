classdef DataInterpCondition<handle
    properties
        string
        stringIndices
        interpMethod
    end
    methods
        function obj=DataInterpCondition(string,stringIndices,interpMethod)
            if nargin>0
                obj.string=string;
                obj.stringIndices=stringIndices;
                obj.interpMethod=interpMethod;
            end
        end
        function method=Check(obj,varName,defaultMethod)
            if strcmpi(varName(obj.stringIndices),obj.string)
                method=obj.interpMethod;
            else
                method=defaultMethod;
            end
        end
    end
end