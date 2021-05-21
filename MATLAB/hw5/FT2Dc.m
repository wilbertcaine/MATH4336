function [out] = FT2Dc(in)
[Nx, Ny] = size(in);
f1 = zeros(Nx,Ny);
for ii = 1:Nx
    for jj = 1:Ny
         f1(ii,jj) = exp(1i*pi*(ii + jj));
    end
end
FT = fft2(f1.*in);
out = f1.*FT;