function [magdb, F, T, mag] = shortTimeFT(signal, fs)

window = kaiser(256,5);
overlapLength = 220;
FFTLength = 512;

[S,F,T] = stft(signal,fs,'Window',window,'OverlapLength',overlapLength,'FFTLength',FFTLength);
mag = abs(S(:,:))';
magdb = mag2db(mag);


if nargout == 0
    mesh(F,T,magdb);
    title('Short-time Fourier Transform')
    xlabel('Frequency(Hz)');
    ylabel('Time(s)');
    zlabel('Magnitude(dB)');
%     surf2stl('stft.stl',F,T*1000,80*magdb);
end

end