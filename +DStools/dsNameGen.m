function name = dsNameGen(no, sensor, label, extention)
% dsNameGen  Generate a formated name, according to the DS name standards. N_cutNumber/KeyI_S_sensorName_A_axis/sensorPlacment_U_unit_L_label
%   name = dsNameGen(no, sensor, axis, unit, label, extention) generates
%   "N_no_S_sensor_A_axis_U_unit_L_label_extention".
%
%   See also dsGen, dsNameAnal.

name = ["N_", num2str(no), "_S_", sensor, "_L_", label, "_"];
if nargin > 3
    name = [name, extention];
end

name = join(name);
name = erase(name, " ");

end