function saveObj(input, savingPath)
if nargin <= 1
    savingPath = uigetfile;
end

input = normalize(input,'range',[0 length(input(1,:))/1.5]);

v = @(x,y,z) join(["v ",x," ",y," ",z,newline], '');
f = @(x,y,z,k) join(["f ",x," ",y," ",z," ",k,newline], '');
nl = @(x,y) join([x,newline,y],'');

fid = fopen(savingPath,'w');

lineNo = 1;
theMap = [];
for i = 1:length(input(:,1))
    for j = 1:length(input(1,:))
        fwrite(fid, v(i,j,input(i,j)));
        theMap(i,j) = lineNo;
        lineNo = lineNo+1;
    end
end
for i = 2:length(input(:,1))-1
    for j = 2:length(input(1,:))-1
        fwrite(fid, f(theMap(i,j),theMap(i+1,j),theMap(i,j+1),theMap(i-1,j)));
    end
end
fclose(fid);
end