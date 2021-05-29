addpath('\\Vdidrive\myhome\wcaine\Documents\MATLAB\src\dataset');
addpath('\\Vdidrive\myhome\wcaine\Documents\MATLAB\src\Non-Local-Means-master');
addpath('\\Vdidrive\myhome\wcaine\Documents\MATLAB\src\SSIM');

up_scale = 2; % 2
up_scale_factor = 1; % 1
t_max = 5; % 100
tau = 0.2; % 0.2
beta = 0.05; % 0.05
lambda_h = 1.63; % 1.63
lambda_l = 1.6; % 1.6
gau_sigma = 0.8; % 0.8
mu = 0.1; % {0.1 - 0.5, Inf}
filename = 'lenna.png';

ground_truth = imread(filename);    
if size(size(ground_truth), 2) > 2
    ground_truth = rgb2gray(ground_truth);
end
ground_truth = im2double(ground_truth);
[rows, columns] = size(ground_truth);
for i = 1 : mod(rows, up_scale^up_scale_factor)
    ground_truth(1,:) = [];
end
for i = 1 : mod(columns, up_scale^up_scale_factor)
    ground_truth(:,1) = [];
end

input = ground_truth;
down_input = imresize(input, 1/up_scale^up_scale_factor, 'bilinear');
up_input = imresize(down_input, up_scale^up_scale_factor, 'bicubic');



% 
% figure;
% imshow(up_input);
% 
% output = plot_mu(down_input, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
% 
% figure;
% imshow(input);
% 
% [Gmag,Gdir] = imgradient(input, 'central');
% imshow(imcomplement(Gmag));
% imshow(Gmag);
% 
% title({'title', ['SSIM = ', num2str(ssim(img, ground_truth))]});
% 
% noise_sigma = 0.25;
% noise = randn(size(down_input)) * noise_sigma;
% down_input = down_input + noise;
% down_input = max(down_input, 0);
% down_input = min(down_input, 1);
% 
% denoised_lr = nonLocalMeans(down_input, noise_sigma, noise_sigma, 7, 21);
% noise = down_input - denoised_lr;
% 
% hr_denoised_lr = plot_mu(denoised_lr, up_scale, up_scale_factor, t_max, tau, beta, lambda_h, lambda_l, gau_sigma, mu);
% 
% noise_up = imresize(noise, up_scale^up_scale_factor, 'bilinear');
% noise_hr_denoised_lr = hr_denoised_lr + noise_up;
% 
% figure;
% imshow(noise_hr_denoised_lr);