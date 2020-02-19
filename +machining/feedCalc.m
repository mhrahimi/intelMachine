function feedOut = feedCalc(spindleSpeed, numTooth, feedIn, flag)
% feedCalc  convert the fedd rate unit from mm/tooth to mm/min.
%   feedOut = feedCalc(spindleSpeed, numTooth, feedIn) feedOut(mm/min) =
%   nN.(mm/tooth)
%
%   feedOut = feedCalc(spindleSpeed, numTooth, feedIn, flag = 1) feedOut(mm/tooth) =
%   (mm/min)/nN
%
%   See also toothPassing.

if nargin == 3 || flag == 0
    feedOut = spindleSpeed*numTooth*feedIn; % (mm/min)
end
if nargin == 4 && flag == 1
    feedOut = feedIn/(spindleSpeed*numTooth); % (mm/tooth)
end

end