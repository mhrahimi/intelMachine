function [data, info] = read(obj, varargin)
[input, response] = obj.readNextItem;
data(1,1) = input;
data(1,2) = response;

info.Label = response;
end