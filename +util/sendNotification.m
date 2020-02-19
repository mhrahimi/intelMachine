function response = sendNotification(vals, notificationMode, url)

val(1:3) = strings;
if 1 <= nargin
    val(1:length(vals)) = vals;
end

if nargin <=1
    notificationMode = 0;
end

if ~isnan(notificationMode)
    if nargin <= 2
        url = 'https://maker.ifttt.com/trigger/matlabTrigger/with/key/dMMJUNdj_A8XUli1c3TIu8';
    end
    
    response = webwrite(url,"value1",val(1),"value2",val(2),"value3",val(3));
    
    if notificationMode
        soundAdd = "C:\Windows\Media\Windows Message Nudge.wav";
        if isfile(soundAdd)
            [y, Fs] = audioread(soundAdd);
            sound(y, Fs, 16);
        end
    end
end

end