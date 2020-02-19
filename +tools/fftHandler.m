function [P1, f] = fftHandler(input, Fs)
% fftHandler  calculates the Fast Fourier transform.
%   [P1, f] = fftHandler(input, Fs) Calculates fft of input with a sampling frequency of Fs and output the magnitude in P1 and frequency in f.
%
%   [P1, f] = fftHandler(input) Calculates the fft of the table input, given that the first row of the table is time.
%
%   fftHandler(input, Fs) Plots the fft of input with a samplling frequncy
%   of Fs.
%
%   See also fft.

graphingIsOn= 0;
if nargout == 0
    graphingIsOn = 1;
end

if isa(input, 'table')
    input = table2array(input);
    time = input(:,1);
    Fs = 1/(time(2,1)-time(1,1));
    T = 1/Fs;
    L = length(time);
    t = (0:L-1)*T;        % Time vector
else
    T = 1/Fs;
    L = length(input);
    t = (0:L-1)*T;        % Time vector
end


% arr = arr(:, 2:end);
Y = fft(input);
P2 = abs(Y/L);
P1 = P2(1:floor(L/2)+1, :);
P1(2:end-1, :) = 2*P1(2:end-1, :);

f = Fs*(0:(L/2))/L;

if graphingIsOn
%     figure;
    plot(f, P1);
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
end

end