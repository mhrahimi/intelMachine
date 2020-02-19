function size = squaredSize(num)

primeFactors = factor(num);
size(1) = prod(primeFactors(1:2:end));
size(2) = 1;
if 1 < length(primeFactors)
    size(2) = prod(primeFactors(2:2:end));
end
end