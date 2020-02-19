function filteredSignal = forceVibFilt(signal, Fs, spindleSpeed, numFlutes)
notchWidth = 20;
% notchWidth = 2*pi/Fs;
% [~, ~, ~,tpAmp, tpFreq, tpAmpInd] =  toothPassingPeaks(data, samplingFreq, spindleSpeed, numFlutes, graphingIsOn, structOutIsOn)
% [toothPassingFrequency, toothPassingInterval, samplesPerToothPassing] = machining.toothPassingCalc(spindleSpeed, numFlutes, Fs);
% freq2filt = toothPassingFrequency/numFlutes:toothPassingFrequency/numFlutes:(Fs/2);
[btAmp, btFreq, ~, tpAmp, tpFreq, ~] = machining.toothPassingPeaks(signal, Fs, spindleSpeed, numFlutes, 0);
filteredSignal = tools.notchFilter(signal, [0; tpFreq], Fs, notchWidth);

if nargout == 0
    subplot(2,1,1);
%     util.fftHandler(signal, Fs);
    machining.toothPassingPeaks(signal, Fs, spindleSpeed, numFlutes,1);
    title("Original Signal");
%     legend('Toothpassing Harmonics', 'Toothpassing Peaks', 'Peaks');
    hold on
%     for lx = tpFreq'
%         xline(lx, '--r');
%     end
%     plot(tpFreq, tpAmp, 'o');
    hold off
    subplot(2,1,2);
%     util.fftHandler(filteredSignal, Fs);
%     hold on
%     for lx = tpFreq'
%         xline(lx, '--r');
%     end
%     plot(btFreq, btAmp, '+');
    machining.toothPassingPeaks(filteredSignal, Fs, spindleSpeed, numFlutes,-Inf);
    title("Filtered Signal");
    hold off
end

end