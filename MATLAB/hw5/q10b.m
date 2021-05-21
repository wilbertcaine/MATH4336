X = imread('Fig5.26a.jpg');
B = fft2(double(X));
shiftB = fftshift(B);
C = 255 * mat2gray(abs(shiftB));
imshow(C);
[Nx, Ny] = size(B);
d = abs(B(1,1) / (Nx*Ny))