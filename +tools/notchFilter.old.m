function filteredSignal = notchFilter(inputSignal, notchFreq, Fs, notchWidth)

fn = Fs/2;              % Nyquist frequency

% if length(notchWidth) == length(notchFreq)

notchZeros = [];
for i = 1:length(notchFreq)
    notchFreqInstance = notchFreq(i);
    if i <= length(notchWidth)
        notchWidthInstance = notchWidth(i);
    else
        notchWidthInstance = notchWidth(length(notchWidth));
    end
    
    freqRatio = notchFreqInstance/fn;      % ratio of notch freq. to Nyquist freq.
    
    
    % Compute zeros
    notchZeros = [notchZeros, exp( sqrt(-1)*pi*freqRatio ), exp( -sqrt(-1)*pi*freqRatio )];
    
    % Compute poles
    notchPoles = (1-notchWidthInstance) * notchZeros;
    
    % figure;
    % zplane(notchZeros.', notchPoles.');
    
    b = poly( notchZeros ); %  Get moving average filter coefficients
    a = poly( notchPoles ); %  Get autoregressive filter coefficients

end

filteredSignal = filter(b,a,inputSignal);

if nargout == 0
    tools.fftHandler(filteredSignal, Fs);
end

end