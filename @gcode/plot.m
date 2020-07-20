function plot(obj, options)
numEntry = height(obj.log);
% for i = 1:numEntry
%     x = obj.log.X(i);
%     y = obj.log.Y(i);
%     z = obj.log.Z(i);
%     plot3(x,y,z,'-o')
%     hold on
% end
% hold off
plot3(obj.log.X, obj.log.Y, obj.log.Z, ":black")
if 2 <= nargin & (isfield(options, 'wp') | isfield(options, 'workpiece'))
    hold on
    st.x = 0; st.y = 0; st.z = 0;
    plotCube(st, options.wp);
    hold off
end
if 2 <= nargin & isfield(options, 'animated') & options.animated
    hold on
    comet3(obj.log.X, obj.log.Y, obj.log.Z);
    hold off
end


end
function plotCube(st, wp)
lineSpec = "-- c";
hold on
plot3([st.x, st.x, wp.x, wp.x, st.x],[st.y, wp.y, wp.y, st.y, st.y]...
    , [st.z, st.z, st.z, st.z, st.z], lineSpec)
plot3([st.x, st.x, wp.x, wp.x, st.x],[st.y, wp.y, wp.y, st.y, st.y]...
    , [-wp.z, -wp.z, -wp.z, -wp.z, -wp.z], lineSpec)
plot3([st.x, st.x], [st.y,st.y], [st.z,-wp.z], lineSpec);
plot3([st.x, st.x], [wp.y,wp.y], [st.z,-wp.z], lineSpec);
plot3([wp.x, wp.x], [wp.y,wp.y], [st.z,-wp.z], lineSpec);
plot3([wp.x, wp.x], [st.y,st.y], [st.z,-wp.z], lineSpec);
hold off
end