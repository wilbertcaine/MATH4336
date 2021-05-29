function f = noiseadd(u, sigma)
    A = u + (randn(size(u))*sigma);
    A = min(A, 1);
    A = max(A, 0);
    f = A
end