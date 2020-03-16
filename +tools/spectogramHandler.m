function [mag, f, time] = spectogramHandler(signal, Fs, windowSize, skipSize)

t = 1;
for rightEnd = windowSize:skipSize:length(signal)
    leftEnd = rightEnd - windowSize + 1;
    thisSignal = signal(leftEnd: rightEnd);
    [mag(t,:), f] = tools.fftHandler(thisSignal, Fs);
    
    t = t+1;
end

mag = mag(:,2:end);
f = f(2:end);
time = [windowSize:skipSize:length(signal)]/Fs;

if nargout == 0
    mesh(f,time,mag);
    xlabel('Frequency (Hz)');
    ylabel('Time (S)');
    zlabel('Magnitude');
end
    
end