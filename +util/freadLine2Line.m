function out = freadLine2Line(filePath, sl, el)

% byteNum = 10;
fid = fopen(filePath,'r');
% fseek(fid, (sl-1)*byteNum,'bof');
% i = 1;
% while i ~= sl
%     fgetl(fid);
%     i = i+1;
% end
out = textscan(fid,'%f',1,'delimiter','\n', 'headerlines',sl-1);
out = out{1,1};

% out = str2double(fgetl(fid));
for i = sl:el-1
    out = [out; str2double(fgetl(fid))];
end
fclose(fid);

end