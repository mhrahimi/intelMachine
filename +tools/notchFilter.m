function filteredSignal = notchFilter(inputSignal, notchFreq, Fs, filtWidth)
filteredSignal = inputSignal;

for i = 1:length(notchFreq)
    if notchFreq(i) == 0
        filteredSignal = zeroNotch(inputSignal, Fs, filtWidth);
    else
        wo = notchFreq(i)/(Fs/2);
        if wo == 1
            wo = .99999;
        end
        bw = wo/filtWidth;
        [b,a] = iirnotch(wo,bw);
        filteredSignal = filter(b,a,filteredSignal);
    end
end

end

function zoroFilteredSignal = zeroNotch(inputSignal, Fs, notchWidth)

fn = Fs/2;              % Nyquist frequency

% if length(notchWidth) == length(notchFreq)

notchZeros = [];
notchFreq = 0;
notchWidth = 1/notchWidth;

notchFreqInstance = notchFreq;
    notchWidthInstance = notchWidth;


freqRatio = notchFreqInstance/fn;      % ratio of notch freq. to Nyquist freq.


% Compute zeros
notchZeros = [notchZeros, exp( sqrt(-1)*pi*freqRatio ), exp( -sqrt(-1)*pi*freqRatio )];

% Compute poles
notchPoles = (1-notchWidthInstance) * notchZeros;

% figure;
% zplane(notchZeros.', notchPoles.');

b = poly( notchZeros ); %  Get moving average filter coefficients
a = poly( notchPoles ); %  Get autoregressive filter coefficients



zoroFilteredSignal = filter(b,a,inputSignal);


end