%         function varargout = subsref(obj, S)
%             if 1 <= numel(S) && strcmp(S(1).type, '{}')
%                 % Looks like obj.method(args)
%                 disp(S(1).subs);
%             else
%                 [varargout{1:nargout}] = builtin('subsref', obj, S);
%             end
%         end
%         function [output] = labelArray(obj, varargin)
%             fileAdd = varargin{1};
%
%             indexCell = strfind(obj.File, fileAdd);
%             index = ~cellfun('isempty',indexCell);
%             thisLabel = obj.Label(index);
%
%             fileLength = util.fileLineCount(fileAdd);
%
%             output = cell(0);
%             output(1:fileLength) = thisLabel;
%             %             output = {categorical(output)};
%             output = categorical(output);
%             %             output = [{thisLabel; thisLabel; thisLabel}; {thisLabel; thisLabel; thisLabel}];
%         end
%         function out = rf(ob, varargin)
%             fileAdd = varargin{1};
%
%             out = readmatrix(fileAdd, 'NumHeaderLines', 0)';
%         end