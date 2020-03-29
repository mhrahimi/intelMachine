function [Parts, gNum] = dsGrindup(dsIn, batchSize, doubleOut, ind)
waitbarIsOn = 0;
if nargin <=3
    if nargin <= 2
        doubleOut = 1;
    end
    ind = 1:dsIn.Len;
end
% linecount db load

if waitbarIsOn, wBar = waitbar(0,'Grinding-up..');, end
for i = ind 
    thisFileLineCount = util.fileLineCount(dsIn.Files{i}); % TODO speedup by adding cach option
    parts = internalGrinderFunction(thisFileLineCount, batchSize, doubleOut);
    Parts(i) = {parts};
    gNum(i) = length(parts);
    if waitbarIsOn, waitbar(i/dsIn.Len, wBar);, end
end

if waitbarIsOn, close(wBar);, end

% dsOut.gread = @(no,piece) gread(no,piece);
% 
%     function dataOut = gread(no, piece)
%         if dsOut.Len < no || dsOut.gNum(no) < piece
%             dataOut = NaN;
%             return
%         end
%         sl = dsOut.Parts(no);
%         sl = sl{1};
%         sl = sl(piece,1);
%         
%         el = dsOut.Parts(no);
%         el = el{1};
%         el = el(piece,2);
%         dataOut = util.freadLine2Line(dsOut.Files{no},sl,el);
%     end

end

function parts = internalGrinderFunction(len, batchSize, doubleOut)

% i = 1;
% for j = batchSize:batchSize:len
%     parts(i,:) = [j-batchSize+1, j];
%     i= i+1;
% end
parts(:,2) = batchSize:batchSize:len;
parts(:,1) = parts(:,2)-batchSize+1;


if doubleOut && rem(len, batchSize) % do the backward grinding only if it doesn't match the forward one
%     for j = len:-batchSize:batchSize
%         parts(i,:) = [j-batchSize+1, j];
%         i= i+1;
%     end
    part2(:,2) = len:-batchSize:batchSize;
    part2(:,1) = part2(:,2)-batchSize+1;
    
    parts = [parts; part2];
end

if ~exist('parts')
    parts = NaN;
end

end