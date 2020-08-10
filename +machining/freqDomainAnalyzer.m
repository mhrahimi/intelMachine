function freqDomainAnalyzer(data, samplingFreq, spindleSpeed, numFlutes, graphingIsOn)
if 5 <= nargin & 1 < graphingIsOn
    maxProcessing = graphingIsOn;
else
    maxProcessing = samplingFreq/2;
end
calc.spFreq = spindleSpeed / 60;
calc.tpFreq = calc.spFreq * numFlutes; % omega_T (hz)

calc.samplesPerToothPassing = samplingFreq/calc.tpFreq;

harmonics.sp = [calc.spFreq:calc.spFreq:maxProcessing];
harmonics.tp = [calc.tpFreq:calc.tpFreq:maxProcessing];

if graphingIsOn
    [amp, freq] = tools.fftHandler(data, samplingFreq);
    plot(freq, amp, 'black');
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    xlim([0, maxProcessing]);
    hold on
    
    xLineDraw(harmonics.sp, '--red');
    xLineDraw(harmonics.tp, '-.blue');
    hold off
end
end
function lineSetHandle = xLineDraw(lineSet, options)
    lineSetHandle = arrayfun(@(x) xline(x, options), lineSet);
end