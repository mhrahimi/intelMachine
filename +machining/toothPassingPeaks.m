function [bpAmp, bpFreq, bpAmpInd,tpAmp, tpFreq, tpAmpInd] =  toothPassingPeaks(data, samplingFreq, spindleSpeed, numFlutes, graphingIsOn, structOutIsOn)
%% constant
freqTolerance = 20;
if nargin < 5
    graphingIsOn = 0;
end

%%
if isa(data, 'table')
    data = table2array(data);
end

%% calculations (external funcitons)
[amp, freq] = tools.fftHandler(data, samplingFreq);
if graphingIsOn
    %     figure;
    plot(freq, amp);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    hold on
end
toothPassingFrequency = machining.toothPassingCalc(spindleSpeed, numFlutes);

%% toothpassing peaks
numHarmonics = floor((samplingFreq/2) / (toothPassingFrequency/numFlutes));
harmonic = @(harmonicNo) toothPassingFrequency*harmonicNo/numFlutes;

% pre-defination
tpAmp = zeros(numHarmonics,1);
tpAmpInd = zeros(numHarmonics,1);
tpFreq = zeros(numHarmonics,1);

% tooth passing effect
for i = 1:numHarmonics
    smallerThan = (harmonic(i) - freqTolerance < freq);
    biggerThan = (freq < harmonic(i) + freqTolerance);
    freqInd = smallerThan & biggerThan;
    [tpAmp(i), tpAmpInd(i)] = max(amp.*freqInd');
    tpFreq(i) = freq(tpAmpInd(i));
end

% in between the harmonics
if samplingFreq < length(data)
    %     AI deactivated
    %     [~, peaksLogic] = ml.modelApply(amp, 'fftPeakModel.mat');
    
    for i = 1:numHarmonics-1
        sectionStart = tpAmpInd(i)+freqTolerance;
        sectionEnd = tpAmpInd(i+1)-freqTolerance;
        thisSection = sectionStart:sectionEnd;
        %         [bpAmp(i), bpAmpInd(i)] = max(amp(thisSection) .*
        %         peaksLogic(thisSection));  Turn AI off
        [bpAmp(i), bpAmpInd(i)] = max(amp(thisSection));
        bpAmpInd(i) = bpAmpInd(i) + sectionStart;
        bpFreq(i) = freq(bpAmpInd(i));
    end
else
    for i = 1:numHarmonics-1
        sectionStart = tpAmpInd(i)+1;
        sectionEnd = tpAmpInd(i+1)-1;
        thisSection = sectionStart:sectionEnd;
        [bpAmp(i), bpAmpInd(i)] = max(amp(thisSection));
        bpAmpInd(i) = bpAmpInd(i) + sectionStart;
        bpFreq(i) = freq(bpAmpInd(i));
    end
    
    %     bpAmp = nan;
    %     bpFreq = nan;
    %     bpAmpInd = nan;
end

%% plotting
if graphingIsOn
    legP = legend('Location', 'northwest');
    if graphingIsOn > -5
        for i = 1:numHarmonics
            harmonicP = xline(harmonic(i),'red --');
        end
        legend([harmonicP],'Toothpassing Harmonics');
    end
    if graphingIsOn > -4
        tpPeaksP = plot(tpFreq, tpAmp, 'X red');
        legend([harmonicP, tpPeaksP],'Toothpassing Harmonics', 'Toothpassing Peaks', 'Location',' northwest');
    end
    if graphingIsOn > -3
        ibPeaksP = plot(bpFreq, bpAmp, '+ black');
        legend([harmonicP, tpPeaksP, ibPeaksP],'Toothpassing Harmonics', 'Toothpassing Peaks', 'Peaks','Location','northwest');
    end
    if graphingIsOn == -inf
        for i = 1:numHarmonics
            harmonicP = xline(harmonic(i),'red --');
        end
        legend([harmonicP],'Toothpassing Harmonics');
        ibPeaksP = plot(bpFreq, bpAmp, '+ black');
        legend([harmonicP, ibPeaksP],'Toothpassing Harmonics', 'Peaks','Location','northwest');
    end
    % plot(freq(2:end),abs(diff(amp)),'black');
    % plot(freq(1:end-2),abs(diff(diff(amp))),'yellow');
    %     if graphingIsOn > -2
    %         AIPeaksP = util.markedPlot(amp, peaksLogic, freq', 0, 'yellow O');
    %         legend([harmonicP, tpPeaksP, ibPeaksP, AIPeaksP],'Toothpassing Harmonics', 'Toothpassing Peaks', 'Peaks' , 'AI detection','Location','northwest');
    %     end
    %     legend([harmonicP, tpPeaksP, ibPeaksP],'Toothpassing Harmonics', 'Toothpassing Peaks', 'In Between the Hormanics peak','Location','northwest');
    %     legend(legP);
    hold off
end

%% struct gen
if nargin>=6 && structOutIsOn
    bp.bpAmp = bpAmp;
    bp.bpFreq = bpFreq;
    ind.bpAmpInd = bpAmpInd;
    tp.tpAmp = tpAmp;
    tp.tpFreq = tpFreq;
    ind.tpAmpInd = tpAmpInd;
    
    bpAmp = struct2table(bp);
    bpFreq = struct2table(tp);
end

end
















