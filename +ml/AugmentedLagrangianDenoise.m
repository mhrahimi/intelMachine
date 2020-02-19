function denoisedSignal = AugmentedLagrangianDenoise(signal)
% http://www.ccom.ucsd.edu/~peg/papers/ALvideopaper.pdf
% credit goes to: https://dsp.stackexchange.com/a/3080/41796 
% All I've done was modification of a few lines
mu = .5;
denoisedSignal = denoisetv(signal,mu);

end

function f = denoisetv(g,mu)
I = length(g);
u = zeros(I,1);
y = zeros(I,1);
rho = 10;

eigD = abs(fftn([-1;1],[I 1])).^2;
for k=1:100
    f = real(ifft(fft(mu*g+rho*Dt(u)-Dt(y))./(mu+rho*eigD)));
    v = D(f)+(1/rho)*y;
    u = max(abs(v)-1/rho,0).*sign(v);
    y = y - rho*(u-D(f));
end
end

function y = D(x)
y = [diff(x);x(1)-x(end)];
end

function y = Dt(x)
y = [x(end)-x(1);-diff(x)];
end